namespace :stripe do
  desc 'Sync Users with Stripe'

  task sync_users: :environment do
    users = User.where(stripe_customer_id: nil)

    users.each do |user|
      customer = Stripe::Customer.create(email: user.email)
      user.update(stripe_customer_id: customer.id)
      puts "User #{user.email} update with stripe_customer_id: #{user.stripe_customer_id}"
    end

    puts 'Users synced with Stripe successfully!'
  end

end
