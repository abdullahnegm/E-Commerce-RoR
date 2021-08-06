class AddBillingAddressToOrders < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :billing_address, index: true, foreign_key: {on_delete: :cascade}
  end
end
