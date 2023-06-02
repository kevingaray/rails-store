module Admin
  class ItemsChangeLogsController < ApplicationController
    before_action :verify_is_admin

    def index
      @itemschangelogs = ItemsChangeLog.all
    end

  end
end