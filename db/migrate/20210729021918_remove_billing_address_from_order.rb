class RemoveBillingAddressFromOrder < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :billing_address
  end
end
