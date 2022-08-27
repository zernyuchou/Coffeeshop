class Discount < ApplicationRecord
  belongs_to :discountable_from, class_name: 'Item'
  belongs_to :discountable_to, class_name: 'Item'

  validates :amount, presence: true
  validates :discountable_from_id, presence: true, uniqueness: { scope: :discountable_to_id }
  validate :item_uniqueness

  scope :with_items, -> (item_ids) { where(discountable_from_id: item_ids).or(where(discountable_to_id: item_ids)) }

  def items
    [discountable_from, discountable_to].sort_by(&:price).reverse
  end

  def price
    (items.first.price * amount/100.0).to_i
  end

  def discountable(item)
    [discountable_from, discountable_to].excluding(item).first
  end

  def self.find_with_items(from_id, to_id)
    find_by(discountable_from_id: from_id, discountable_to_id: to_id) || find_by(discountable_from_id: to_id, discountable_to_id: from_id)
  end

  def self.by_items
    item_ids = Discount.all.pluck(:discountable_from_id, :discountable_to_id).flatten.uniq
    items = Item.find(item_ids)

    result = {}

    items.map do |item|
      discounts = item.discounts - result.values.flatten

      result[item] = discounts if discounts.present?
    end

    result
  end

  private

  def item_uniqueness
    errors.add(:base, message: 'Same items. You have to select different items.') if discountable_from_id == discountable_to_id
    errors.add(:base, message: 'Discount with the items already exist.') if Discount.where(discountable_from_id: discountable_to_id, discountable_to_id: discountable_from_id).present?
  end
end
