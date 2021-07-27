class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :ordered_boolean, default: false
      t.string :billing_address

      t.timestamps
    end
  end
end
