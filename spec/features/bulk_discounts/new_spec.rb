require 'rails_helper'

RSpec.describe 'BulkDiscount#new' do
  before :each do
    @m1 = Merchant.create!(name: 'Creepy Cuddles')

    visit new_merchant_bulk_discount_path(@m1)
  end

  it "has a form to create a new bulk discount" do

    fill_in 'Name', with: 'Drip More For Less'
    fill_in 'Percentage discount', with: 50
    fill_in 'Quantity threshold', with: 20

    click_button 'Submit'

    expect(current_path).to eq(merchant_bulk_discounts_path(@m1))

    expect(page).to have_content(50)
    expect(page).to have_content(20)
    save_and_open_page
    
    expect(page).to have_content("Drip More For Less")
    # expect(page).to have_content(BulkDiscount.last.quantity_threshold)
  end
end
