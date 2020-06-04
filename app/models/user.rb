class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books , dependent: :destroy
  has_many :book_comments , dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人
  attachment :profile_image
  validates :name, presence: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

  def follow(user_id)
    if self.id.to_s != user_id.to_s
       follower.create(followed_id: user_id)
    end
  end

  def unfollow(user_id)
  follower = self.follower.find_by(followed_id: user_id)
  follower.destroy if follower
  end

  def following?(user)
  self.following_user.include?(user)
  end


end
