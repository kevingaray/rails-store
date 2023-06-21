class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  has_many :likes, dependent: :destroy
  has_many :orders
  has_many :items_change_log
  has_many :comments, as: :commentable

  def admin?
    admin == true
  end

  def support?
    support == true
  end

  # for soft delete function
  def active_for_authentication?
    super && !deleted_at
  end

  # provide a custom message for a deleted account
  def inactive_message
    !deleted_at ? super : :deleted_account
  end
  
end
