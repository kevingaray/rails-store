json.data do
  json.user do
    json.id @user.id
    json.name "#{@user.first_name} #{@user.last_name}"
    json.email @user.email
    json.deleted @user.deleted_at if @user.deleted_at
  end

  json.comments @user.comments do |comment|
    if comment.approved  || @current_user.admin
      json.id comment.id
      json.approved comment.approved
      json.body comment.body
      json.rate comment.rate
      json.author comment.user.email
    end
  end
end
