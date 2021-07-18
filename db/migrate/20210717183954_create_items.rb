class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|

      t.string  :title, null: false
      t.decimal :price, null: false
      t.decimal :dis_price
      t.string  :slug
      t.string  :description, null: false
      t.string  :picture 

      t.timestamps
    end
  end
end
