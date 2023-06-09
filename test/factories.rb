require 'faker'

FactoryBot.define do

  factory :item do
    name { Faker::Food.unique.fruits }
    price  { rand(10.00..50.00) }
    stock { rand(5..15) }
  end

  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email { Faker::Internet.email }
    facebook_id { '101043572779060' }
    password { 'securepassword' }
  end

  factory :admin_user, class: User do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email { Faker::Internet.email }
    admin { true }
    support { true }
    password { 'securepassword' }
  end

  factory :comment do
    association :commentable, factory: :item
    user
  end

  factory :like do
    user
    item
  end

  factory :items_change_log do
    item
    user
    column_name { 'price' }
    prev_value { item.price }
    new_value { item.price + rand(10.00..50.00) }
  end

  # factory :commentable_user, class: User do
  #   first_name { 'Pepe' }
  #   last_name  { 'Pew' }
  #   admin { false }
  #   email { 'pepepew@rails.com' }
  #   password { 'securepassword' }
  # end

  # factory :access_token, class: Doorkeeper::AccessToken do
  #   application
  #   expires_in { 2.hours }
  # end

  # factory :application, class: Doorkeeper::Application do
  #   name  { 'test' }
  #   redirect_uri { '' }
  #   scopes { '' }
  # end
end
