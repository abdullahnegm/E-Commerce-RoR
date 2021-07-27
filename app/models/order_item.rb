class OrderItem < ApplicationRecord

    belongs_to :order, dependent: :destroy

    belongs_to :item, dependent: :destroy

    def get_final_price
        return item.dis_price if item.dis_price
        item.price
    end

    def get_total_price
        get_final_price * quantity
    end

end