class Micropost < ActiveRecord::Base
  belongs_to :user
  has_many :relationfavorites, foreign_key: "favorited_id", dependent: :destroy
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
    WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
    user_id: user.id)
  end

  def favorite_user(other_user)
    relationfavorites.find_by(favorite_id: other_user.id)
  end

end
