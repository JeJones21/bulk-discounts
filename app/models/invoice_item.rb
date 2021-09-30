class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item
  has_one :merchant, through: :item
  has_many :bulk_discounts, through: :merchant
  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  def total_rev
   unit_price * quantity
 end

 def discount_finder
   item.merchant.bulk_discounts.where('bulk_discounts.quantity_threshold <= ?', quantity)
                 .select('bulk_discounts.*')
                 .order(percentage_discount: :desc)
                 .first
 end

 def disco_rev
    if discount_finder.blank?
      total_rev
    else
      (total_rev - (total_rev * (discount_finder.percentage_discount.to_f/100)))
    end
  end
end
