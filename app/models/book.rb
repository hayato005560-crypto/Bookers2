class Book < ApplicationRecord
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.search_for(word, search)
    if word.blank?
      return Book.all
    end

    case search
    when "perfect_match"
      Book.where(title: word)
    when "forward_match"
      Book.where("title LIKE ?", "#{word}%")
    when "backward_match"
      Book.where("title LIKE ?", "%#{word}")
    when "partial_match"
      Book.where("title LIKE ?", "%#{word}%")
    else
      Book.all
    end
  end
  
end