class AddDeliveryTypeToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :delivery_type, :string
  end
end
