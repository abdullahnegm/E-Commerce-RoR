module Denormalizers
    class Item
        att.reader :item

        def initialize item
            @item = item
        end

        def to_hash
            p "############################"
            p "############################"
            p "############################"
            p "############################"
            %w[id title description price dis_price user].map { |field| [field: send(field)] }.to_h
        end

        def id
            item.id
        end

        def title
            item.title
        end

        def description
            item.description
        end

        def price
            item.price
        end

        def dis_price
            item.dis_price
        end

        def user
            [ item.username, item.age ]
        end


    end
end