require 'rails_helper'

RSpec.describe 'bulk discount show page' do
  before :each do
    @m1 = Merchant.create!(name: 'Creepy Cuddles')

    @disco1 = BulkDiscount.create!(name: "10% OFF", merchant_id: @m1.id, percentage_discount: 10, quantity_threshold: 5)

    visit merchant_bulk_discount_path(@m1, @disco1)
  end

  it "shows the discount attributes" do
    expect(page).to have_content(@disco1.name)
    expect(page).to have_content(@disco1.percentage_discount)
    expect(page).to have_content(@disco1.quantity_threshold)
  end

  it "has a link to edit the discount" do

    click_link "Edit Discount"

    expect(current_path).to eq(edit_merchant_bulk_discount_path(@m1, @disco1))
  end

  it "has an edit discount form" do
    visit edit_merchant_bulk_discount_path(@m1, @disco1)

    expect(page).to have_field('Name', with: @disco1.name)
    expect(page).to have_field('Percentage discount', with: @disco1.percentage_discount)
    expect(page).to have_field('Quantity threshold', with: @disco1.quantity_threshold)

    fill_in 'Name', with: 'Karen Discount'
    fill_in 'Percentage discount', with: 75
    fill_in 'Quantity threshold', with: 1

    click_button 'Submit'

    expect(current_path).to eq(merchant_bulk_discount_path(@m1.id, @disco1.id))

    expect(page).to have_content('Karen Discount')
    expect(page).to have_content(75)
    expect(page).to have_content(1)
  end
end
