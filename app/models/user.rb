class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  has_many :likes, dependent: :destroy

  def admin?
    admin == true
  end

  def support?
    support == true
  end

end