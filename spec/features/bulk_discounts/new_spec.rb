require 'rails_helper'

RSpec.describe 'BulkDiscount#new' do
  @m1 = Merchant.create!(name: 'Creepy Cuddles')

end

it "has a form to create a new bulk discount" do
  visit merchant_bulk_discounts_path(@m1)

    click_link "Create Bulk Discount"

    expect(current_path).to eq(new_merchant_bulk_discount_path(@m1))

    fill_in 'Name', with: 'Drip More For Less'
    fill_in 'Percentage Discount', with: '50'
    fill_in 'Quantity Threshold', with: '20'

    click_button 'Submit'

    expect(current_path).to eq(merchant_bulk_discounts_path(@m1))
    expect(page).to have_content("Discount Percentage: 20")
    expect(page).to have_content("Drip More For Less")
    expect(page).to have_content(BulkDiscount.last.quantity_threshold)

end
