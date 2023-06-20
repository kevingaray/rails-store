module Items
  module Query
    class Index

      def initialize(params)
        @search = params[:search]
        @column = params[:sort]
        @direction = params[:direction]
        @tags = params[:tags]
      end

      def call
        @items = Item.where(deleted_at: nil)
        filter_by_search if @search
        filter_by_column_direction if @column || @direction
        filter_by_tag if @tags
        @items
      end

      private

      def filter_by_search
        @items = @items.where('LOWER(items.name) LIKE LOWER(?)', "%#{@search}%")
      end

      def filter_by_column_direction
        @items = if sort_column == 'likes'
                   @items.left_outer_joins(:likes)
                         .select('items.*, count(likes)')
                         .group('items.id')
                         .order("count(likes) #{sort_direction}")
                 else
                   @items.order("#{sort_column} #{sort_direction}")
                 end
      end

      def filter_by_tag
        @items = @items.joins(:tags).where(tags: { name: @tags })
      end

      def sort_column
        %w[id name price stock likes].include?(@column) ? @column : 'name'
      end

      def sort_direction
        %w[asc desc].include?(@direction) ? @direction : 'asc'
      end

    end
  end
end
