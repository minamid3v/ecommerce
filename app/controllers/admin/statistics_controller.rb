class Admin::StatisticsController < ApplicationController
  before_action :admin_user
  def index
    @day = params[:date].present? ? params[:date].to_date : Date.new
    @select = params[:statistic]
  end
end
