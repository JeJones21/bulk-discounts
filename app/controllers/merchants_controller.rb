# class MerchantsController < ApplicationController
#   before_action :current_merchant, only: :show
#
#   def index
#     @merchants = Merchant.all
#   end
#
#   def show
#     @customers = @merchant.favorite_customers
#     @items = @merchant.items_ready_to_ship
#   end
# end
