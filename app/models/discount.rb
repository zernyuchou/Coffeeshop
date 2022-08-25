class Discount < ApplicationRecord
  belongs_to :discountable_from, class_name: 'Item'
  belongs_to :discountable_to, class_name: 'Item'

  validates :amount, presence: true
  validates :discountable_from_id, presence: true, uniqueness: { scope: :discountable_to_id }
  validate :item_uniqueness

  scope :with_items, -> (item_ids) { where(discountable_from_id: item_ids).or(where(discountable_to_id: item_ids)) }

  def applied_price
    ((discountable_from.price + discountable_to.price) * amount / 100.0).to_i
  end

  def self.find_with_items(from_id, to_id)
    find_by(discountable_from_id: from_id, discountable_to_id: to_id) || find_by(discountable_from_id: to_id, discountable_to_id: from_id)
  end

  private

  def item_uniqueness
    errors.add(:base, message: 'Same items. You have to select different items.') if discountable_from_id == discountable_to_id
    errors.add(:base, message: 'Discount with the items already exist.') if Discount.where(discountable_from_id: discountable_to_id, discountable_to_id: discountable_from_id).present?
  end
end
