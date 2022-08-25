class CreateDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :discounts do |t|
      t.references :discountable_from, index: true, foreign_key: {to_table: :items}
      t.references :discountable_to, index: true, foreign_key: {to_table: :items}
      t.integer :amount

      t.timestamps
    end
  end
end
