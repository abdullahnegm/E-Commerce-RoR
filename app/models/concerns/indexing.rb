module Indexing

    def as_indexed_json
        self.as_json({
          only: [:title, :description, :price],
        #   include: {
        #     author: { only: :name },
        #     tags: { only: :name },
        #   }
        })
    end

end