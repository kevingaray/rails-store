module Api
  module V1
    class ApiController < ActionController::API
      include Pagy::Backend
      
    end
  end
end
