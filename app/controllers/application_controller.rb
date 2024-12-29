class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private
  def initialize_search_params
    @searchdata = nil
    @travel_months = []
    @prefectures = 'all_prefectures'
    @night = 'all_nights'
    @people = 'all_people'
    @post_month = []
    @travel_goods = []

    Rails.logger.debug "Search parameters initialized: #{@travel_months.inspect}"
  end
end
