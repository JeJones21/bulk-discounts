class BulkDiscountsController < ApplicationController
  before_action :current_merchant
  def index
    # @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts.all
  end

  def show
    # @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    # @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.new
    @name = params[:name]
  end

  def create
    # @merchant = Merchant.find(params[:merchant_id])
    bulk_discount = @merchant.bulk_discounts.create(bulk_discount_params)

    if bulk_discount.save
      redirect_to merchant_bulk_discounts_path(@merchant)
    else
      flash[:alert] = 'Your form is missing some crucial stuff. Look again!'
      redirect_to new_merchant_bulk_discount_path(merchant)
    end
  end

  def destroy

    BulkDiscount.find(params[:id]).destroy

    redirect_to merchant_bulk_discounts_path(@merchant)
  end

private
  def bulk_discount_params
    params.permit(:id, :name, :percentage_discount, :quantity_threshold)
  end
end
