module Users
  module Operation
    class Destroy

      def initialize(id)
        @id = id
      end

      def call
        user = User.find(@id)
        user.update_attribute(:deleted_at, Time.current)
      end

    end
  end
end
