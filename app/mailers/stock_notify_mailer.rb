class StockNotifyMailer < ApplicationMailer
  def notify_email(item_id)
    @item = Item.find(item_id)
    attachments["#{@item.name}.jpg"] = @item.image.download if @item.image.attached?
    lastlike = @item.likes.order(:created_at).last
    @user = User.find(lastlike.user_id)
    mail(to: @user.email, subject: "Hurry up, last items in stock of #{@item.name}")
  end
end
