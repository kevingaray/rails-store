require 'representable/json'
module Users
  module Representer
    class UserRepresenter < Representable::Decorator
      include Representable::JSON

      property :id
      property :email
      property :name, getter: ->(represented:, **) { "#{represented.first_name} #{represented.last_name}" }
      # property :comments, getter: ->(represented:, **) { represented.comments.count }
      # property :deleted_at
    end
  end
end
