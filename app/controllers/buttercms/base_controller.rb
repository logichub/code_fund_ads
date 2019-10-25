class Buttercms::BaseController < ApplicationController
  layout "blog"
  before_action :set_themes

  protected

  def set_themes
    @body_class = "bg-light"
    @navbar_class = "bg-white"
    @footer_theme = "bg-gray-200"
  end
end
