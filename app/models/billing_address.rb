class BillingAddress < ApplicationRecord

    belongs_to :user
    has_one :order, dependent: :nullify

    validates :shipping_address, length: { in: 6..40 }

end