class BulkDiscountsController < ApplicationController
  before_action :current_merchant

  def index
    @bulk_discounts = @merchant.bulk_discounts.all
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

end
