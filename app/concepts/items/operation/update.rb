module Items
  module Operation
    class Update < ApplicationService

      def initialize(item,item_params,tags_params, user)
        @item = item
        @item_params = item_params
        @tags_params = tags_params
        @user = user
      end

      def call
        if @item.update(@item_params)
          create_or_delete_items_tags(@item, @tags_params)
          save_changes_in_log(@item,@user)
        else
          raise ActiveRecord::RecordInvalid.new(@item)
        end    
      end

      def save_changes_in_log(item,user)
        changes = @item.saved_changes
        changes.each do |k, v|
          next if k == 'updated_at'
          log_entry = ItemsChangeLog.new(item_id: item.id, user_id: user.id)
          log_entry.column_name = k
          log_entry.prev_value = v[0].to_s
          log_entry.new_value = v[1].to_s
          log_entry.save!
        end
      end

    end
  end
end
