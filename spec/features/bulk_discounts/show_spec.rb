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
end
