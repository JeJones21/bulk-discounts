require 'rails_helper'

RSpec.describe 'BulkDiscount#index' do
  before :each do

    @m1 = Merchant.create!(name: 'Creepy Cuddles')
    @m2 = Merchant.create!(name: 'Agave Enterprise')

    @disco1 = @m1.bulk_discounts.create!(percentage_discount: 10,  quantity_threshold: 5)
    @disco2 = @m1.bulk_discounts.create!(percentage_discount: 25,  quantity_threshold: 10)
    @disco3 = @m1.bulk_discounts.create!(percentage_discount: 50,  quantity_threshold: 25)
    @disco4 = @m2.bulk_discounts.create!(percentage_discount: 5,  quantity_threshold: 2)

    visit merchant_bulk_discounts_path(@m1)
  end

  it 'lists all bulk discounts with their percentage discount and quantity threshold' do
   expect(page).to have_content(@disco1.percentage_discount)
   expect(page).to have_content(@disco1.quantity_threshold)
   expect(page).to have_content(@disco2.percentage_discount)
   expect(page).to have_content(@disco2.quantity_threshold)
   expect(page).to have_content(@disco3.percentage_discount)
   expect(page).to have_content(@disco3.quantity_threshold)

   # expect(page).to_not have_content(@disco4.percentage_discount)
   # expect(page).to_not have_content(@disco4.quantity_threshold)
 end
end
