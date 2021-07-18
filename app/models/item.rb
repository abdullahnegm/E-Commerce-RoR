class Item < ApplicationRecord
    after_validation :set_slug, only: [:create, :update]

    validates :title, length: { in: 6..50 }, presence: true
    validates :description, length: { in: 10..700 }, presence: true
    validates :price, format: { with: /\A\d+(?:\.\d{0,2})?\z/, message: "Can Have At Most Two Decimals" }, numericality: { greater_than: 0, less_than: 1000000 }, presence: true
    validates :dis_price, format: { with: /\A\d+(?:\.\d{0,2})?\z/, message: "Can Have At Most Two Decimals" }, numericality: { greater_than: 0, less_than: 1000000 }
    

    def to_param
        "#{id}-#{slug}"
    end

    private
    def set_slug
        self.slug = title.to_s.parameterize
    end 
end