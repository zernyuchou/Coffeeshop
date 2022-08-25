ActiveAdmin.register Discount do
  permit_params :discountable_from_id, :discountable_to_id, :amount

  index do
    selectable_column
    id_column
    column 'Item', :discountable_from
    column 'Item', :discountable_to
    column 'Amount (%)', :amount
    column 'Applied Price (cents)', :total do |discount|
      discount.applied_price
    end
    actions
  end
end
