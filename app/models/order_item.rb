class OrderItem < ApplicationRecord

    belongs_to :order

    belongs_to :item

    def get_final_price
        return item.dis_price if item.dis_price
        item.price
    end

    def get_total_price
        get_final_price * quantity
    end

end