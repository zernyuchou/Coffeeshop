ActiveAdmin.register Item do
  permit_params :name, :price

  index do
    selectable_column
    id_column
    column :name
    column 'Price (cents)', :price
    actions
  end
end
