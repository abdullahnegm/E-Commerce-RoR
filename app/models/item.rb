class Item < ApplicationRecord
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    # include Indexing

    # def as_indexed_json options={}
    #     Denormalizers::Item.new(self).to_hash
    # end

    # def as_indexed_json(options = {})
    #     self.as_json(
    #         only: [:title]
    #     )
    # end

    settings index: { number_of_shards: 1 } do
        mapping dynamic: 'false' do
          indexes :id, type: :integer
          indexes :title
          indexes :description
          indexes :picture
          indexes :slug
          indexes :price, type: :integer
          indexes :dis_price, type: :integer
        end
    end

    after_validation :set_slug

    validates :title, length: { in: 3..50 }, presence: true
    validates :description, length: { in: 10..700 }, presence: true
    validates :price, format: { with: /\A\d+(?:\.\d{0,2})?\z/, message: "Can Have At Most Two Decimals" }, numericality: { greater_than: 0, less_than: 1000000 }, presence: true
    validates :dis_price, allow_blank: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/, message: "Can Have At Most Two Decimals" }, numericality: { greater_than: 0, less_than: 1000000 }
    
    def to_param
        "#{id}-#{slug}"
    end

    private
    def set_slug
        self.slug = title.to_s.parameterize
    end 
end