class CampaignCreativesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_campaign

  def index
    @summary_report = @campaign.summary_report(@start_date, @end_date)
    @reports = @campaign.creative_reports(@start_date, @end_date)

    respond_to do |format|
      format.html
      format.csv do
        send_data(
          CSV.generate { |csv|
            csv << [
              "Creative",
              "Spend",
              "Impressions",
              "Clicks",
              "CTR",
              "CPM",
              "CPC",
            ]
            @reports.each do |report|
              csv << [
                report.scoped_by.name,
                report.gross_revenue,
                report.impressions_count,
                report.clicks_count,
                report.click_rate.round(2),
                report.cpm,
                report.cpc,
              ]
            end
          },
          filename: "campaign-creative-report-#{@campaign.id}-#{@start_date.to_s("yyyymmdd")}-#{@end_date.to_s("yyyymmdd")}.csv"
        )
      end
    end
  end

  private

  def set_campaign
    @campaign = if authorized_user.can_admin_system?
      Campaign.find(params[:campaign_id])
    else
      current_user.campaigns.find(params[:campaign_id])
    end
  end
end
