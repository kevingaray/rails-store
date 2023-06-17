class DislikeUpdateJob < ApplicationJob
  queue_as :default

  def perform (liked)
    if liked
      liked.destroy
    else
      raise "Cannot unlike"
    end
  end
  
end
