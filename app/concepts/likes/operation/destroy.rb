module Likes
  module Operation
    class Destroy < ApplicationService

      def initialize(liked)
        @liked = liked
      end

      def call
        if @liked
          @liked.destroy
        else
          raise "Cannot unlike"
        end
      end
      
    end
  end
end