namespace :stripe do
  desc 'Sync items with Stripe'

  task sync_items: :environment do
    items = Item.where(stripe_price_id: nil)

    items.each do |item|
      product = Stripe::Product.create(name: item.name)
      price = Stripe::Price.create(
        product: product.id,
        unit_amount: (item.price * 100).to_i,
        currency: 'usd'
      )
      item.update(stripe_product_id: product.id, stripe_price_id: price.id)
      puts "Item #{item.name} update with stripe_price_id: #{item.stripe_price_id}"
    end

    puts 'Items synced with Stripe successfully!'
  end

end
