class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books
  attachment :profile_image

  validates :name, length: {minimum: 2}
  validates :name, length: {maximum: 20}
  validates :name, presence:true
  validates :introduction, length: {maximum: 50}

  def books
    return Book.where(user_id: self.id)
  end
end

