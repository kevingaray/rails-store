# Preview all emails at http://localhost:3000/rails/mailers/
class StockNotifyMailerPreview < ActionMailer::Preview
  def preview_notify
    like = Like.last
    StockNotifyMailer.notify_email(like.item.id)
  end
end
