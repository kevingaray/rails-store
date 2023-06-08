module Comments
  module Operation
    class Create

      def initialize(commentable,comment_params,user)
        @commentable = commentable
        @comment_params = comment_params
        @user = user
      end

      def call
        comment = @commentable.comments.new(@comment_params)
        comment.user = @user
        rate = comment.rate
        comment.rate = 3 if rate.nil? || rate < 1 || rate > 5
        comment.save
      end

    end
  end
end
