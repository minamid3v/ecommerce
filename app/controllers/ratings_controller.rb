class RatingsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:rating][:user_id]
    @rating = Rating.new rating_params
    if @rating.save && current_user == @user
      flash[:success] = t "success.rate_success"
      redirect_to @rating.product
    else
      flash[:error] = t "error.rate_failed"
      redirect_to root_path
    end
  end

  private

  def rating_params
    params.require(:rating).permit :point, :user_id, :product_id
  end
end
