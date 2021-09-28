class BulkDiscountsController < ApplicationController
  before_action :current_merchant

  def index
    @bulk_discounts = @merchant.bulk_discounts.all
  end

  def show

    @bulk_discount = BulkDiscount.find(params[:id])
  end

private
  def bulk_discount_params
    params.permit(:name, :percentage_discount, :quantity_threshold)
  end
end
