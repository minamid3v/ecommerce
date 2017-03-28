class Admin::SubCategoriesController < ApplicationController
  before_action :load_sub_category, only: [:show, :update, :destroy]

  def show
  end

  def update
    if @sub_category.update_attributes sub_category_params
      flash[:success] = t "success.update"
      redirect_to :back
    else
      flash[:danger] = t "error.edit_failed"
      redirect_to :back
    end
  end

  def destroy
    if @sub_category.destroy
      flash[:success] = t "success.delete"
      redirect_to :back
    else
      flash[:danger] = t "error.delete_failed"
      redirect_to :back
    end
  end

  private

  def load_sub_category
    @sub_category = SubCategory.find_by id: params[:id]
    unless @sub_category
      flash[:danger] = t "error.sub_category_not_found"
      redirect_to :back
    end
  end

  def sub_category_params
    params.require(:sub_category).permit :name, :description
  end
end
