class Item < ApplicationRecord
  validates :name, :price, presence: true

  default_scope { order(price: :desc) }

  def discounts
    Discount.where(discountable_from_id: id).or(Discount.where(discountable_to_id: id))
  end
end
