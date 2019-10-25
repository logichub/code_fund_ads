class HomeController < ApplicationController
  layout "home"
  before_action :load_data

  def index
    render "/home/index"
  end

  def show
    render "/home/#{params[:id]}"
  end

  private

  def load_data
    @from_date = Date.parse("2019-01-01")
    @property_count = Property.active.count
    @campaign_count = Campaign.active.count
    @impressions_count = ImpressionStats.count(@from_date)
    @click_rate = ImpressionStats.click_rate(@from_date)
    @footer_theme =
      if %w[advertisers].include? params[:id]
        "bg-dark"
      elsif %w[publishers].include? params[:id]
        "bg-white"
      else
        "bg-gray-200"
      end
  end
end
