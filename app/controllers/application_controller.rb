class ApplicationController < ActionController::Base

  private

  def current_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

end
