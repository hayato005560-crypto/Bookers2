class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_one_attached :profile_image

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  validates :email_address, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_nil: true
end