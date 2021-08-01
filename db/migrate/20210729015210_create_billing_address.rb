class CreateBillingAddress < ActiveRecord::Migration[6.1]
  def change
    create_table :billing_addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :shipping_address

      t.timestamps
    end
  end
end
