class LikeUpdateJob < ApplicationJob
  queue_as :default

  def perform (liked,item,user)
    unless liked
      item.likes.create(user_id: user.id)
    else
      raise "You can't like more than once"
    end
  end
end
