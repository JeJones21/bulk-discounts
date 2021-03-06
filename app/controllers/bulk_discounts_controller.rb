class BulkDiscountsController < ApplicationController
  before_action :current_merchant
  def index
    @bulk_discounts = @merchant.bulk_discounts.all
    @holidays = BulkDiscountFacade.holidays

    # GET request in Faraday order
    # get your response.body
    # use this to parse the body: JSON.parse(body)
    # @holidays = all the code you need to get the holiday info out of the api

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

  def edit
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    bulk_discount = BulkDiscount.find(params[:id])

    if bulk_discount.update(edit_params)
      redirect_to merchant_bulk_discount_path(@merchant, bulk_discount)
    else
      redirect_to edit_merchant_bulk_discount_path(@merchant, bulk_discount)
    end
  end

  def destroy

    BulkDiscount.find(params[:id]).destroy

    redirect_to merchant_bulk_discounts_path(@merchant)
  end

private
  def bulk_discount_params
    params.permit(:name, :percentage_discount, :quantity_threshold)
  end

  def edit_params
    params.require(:bulk_discount).permit(:name, :percentage_discount, :quantity_threshold)
  end
end
