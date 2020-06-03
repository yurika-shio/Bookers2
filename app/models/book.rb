class Book < ApplicationRecord
	belongs_to :user
	has_many :book_comments , dependent: :destroy
	has_many :favorites, dependent: :destroy
	validates :title, :body, presence: true, length: { in: 1..20 }
	def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
    end
end
