class Item < ApplicationRecord
  validates :name, :price, presence: true

  default_scope { order(price: :desc) }
end
