class HomeController < ApplicationController
  layout "home"
  before_action :load_data

  def index
    @butter = ButterCMS::Page.get('*', 'home').data.fields
  end

  def show
    @butter = ButterCMS::Page.get('*', params[:id]).data.fields
  end

  private

  def load_data
    # TODO Make sure we cache this data!

    from_date = Date.parse("2019-01-01")
    collections = ButterCMS::Content.fetch([:menu_item, :advertisers, :snippets]).data
    
    @data = {
      from_date: from_date.to_s("bdy"),
      property_count: Property.active.count,
      impressions_count: ImpressionStats.count(from_date),
      campaign_count: Campaign.active.count,
      click_rate: ImpressionStats.click_rate(from_date),
      menu_items: collections.menu_item,
      advertisers: collections.advertisers
    }
    collections.snippets.map.with_object({}) do |snippet, memo|
      @data["snippets_#{snippet.name}"] = snippet.html
    end

    @data = @data.with_indifferent_access
  end
end