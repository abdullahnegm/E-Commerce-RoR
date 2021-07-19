class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :order_item, null: false, foreign_key: true
      t.string :ordered_boolean
      t.string :billing_address

      t.timestamps
    end
  end
end
