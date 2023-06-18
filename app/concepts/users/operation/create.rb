module Users
  module Operation
    class Create

      def initialize(params)
        @params = params
      end

      def call
        user = User.new(@params)
        if user.save
          user
        else
          raise ActiveRecord::RecordInvalid.new(user)
        end
      end

    end
  end
end