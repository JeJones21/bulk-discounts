require 'rails_helper'

RSpec.describe 'BulkDiscount#index' do
  before :each do

    @m1 = Merchant.create!(name: 'Creepy Cuddles')


    @disco1 = @m1.bulk_discounts.create!(name: "10% OFF", percentage_discount: 10,  quantity_threshold: 5)
    @disco2 = @m1.bulk_discounts.create!(name: "25% OFF", percentage_discount: 25,  quantity_threshold: 10)
    @disco3 = @m1.bulk_discounts.create!(name: "50% OFF", percentage_discount: 50,  quantity_threshold: 25)
    @disco4 = @m1.bulk_discounts.create!(name: "5 OFF%", percentage_discount: 5, quantity_threshold: 2)

    visit merchant_bulk_discounts_path(@m1)
  end

  it 'lists all bulk discounts with their percentage discount and quantity threshold' do
     expect(page).to have_content(@disco1.percentage_discount)
     expect(page).to have_content(@disco1.quantity_threshold)
     expect(page).to have_content(@disco2.percentage_discount)
     expect(page).to have_content(@disco2.quantity_threshold)
     expect(page).to have_content(@disco3.percentage_discount)
     expect(page).to have_content(@disco3.quantity_threshold)
  end

  it "shows link to each discount page" do
    expect(page).to have_link(@disco1.name)
    expect(page).to have_link(@disco2.name)
  end

  it "has a link to create a new discount" do
    click_link "Create Bulk Discount"

    expect(current_path).to eq(new_merchant_bulk_discount_path(@m1))
  end

  it "has a link to delete a discount" do

    within("div#bulk_discount-#{@disco1.id}") do
    save_and_open_page
      # expect(page).to have_link("Delete Bulk Discount")

      click_link "Delete Bulk Discount"
    end

    expect(current_path).to eq(merchant_bulk_discounts_path(@m1))
  end

  it 'can display the next three upcoming holidays with their name and date' do
    expect(page).to have_content("Columbus Day 2021-10-11")
    expect(page).to have_content("Veterans Day 2021-11-11")
    expect(page).to have_content("Thanksgiving Day 2021-11-25")
  end
 end
