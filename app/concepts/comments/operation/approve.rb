module Comments
  module Operation
    class Approve

      def initialize(comment_id,user_id)
        @comment_id = comment_id
        @user_id = user_id
      end

      def call
        comment = Comment.find(@comment_id)
        if comment.commentable_id == @user_id.to_i
          comment.approved = true
          comment.save
        else
          raise "Comment doesn't belong to user with id = #{@user_id}"
        end
      end

    end
  end
end
