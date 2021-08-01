class Order < ApplicationRecord

    has_many :order_items#, dependent: :delete_all
    belongs_to :user, dependent: :destroy
    belongs_to :billing_address, optional: true

    validates :billing_address, allow_nil: true, allow_blank: true, presence: true

    def self.current_order current_user
        if !current_user.orders.empty? 
            if current_user.orders.last.ordered_boolean 
                here = current_user.orders.create
                if here.save
                    here
                else
                    here.errors
                end
            else
                current_user.orders.last
            end
        else
            current_user.orders.create
        end
    end

    scope :order_proj, -> { 
        as_json( only: [:id, :quantity, :order_items, :user], include: :user, include: { 
            order_items: { only: [:quantity, :item], include: { 
                item: { only: [:title, :price, :dis_price, :description] } 
                }} 
            }) 
    }

    def get_total_price
        order_items.map { |order_item| p order_item.get_total_price }.sum
    end

    # scope: :by_recent_message, ->{ order(:last_message_posted_at) }
    # User.by_recent_message.limit(5)

end