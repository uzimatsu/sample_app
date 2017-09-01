class Micropost < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy

  default_scope -> { order('created_at DESC') }
  scope :including_replies, ->(user){ where("in_reply_to = ? OR in_reply_to = ?
    OR user_id = ?", "", "@#{user.id}\-#{user.name.sub(/\s/,'-')}", user.id)}
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  before_save :reply_user

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
    WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
    user_id: user.id)
  end

  def self.from_message(user)
    where("in_reply_to = ?", "@#{user.id.to_s}")
  end

  def like_by(user)
    likes.find_by(user_id: user.id)
  end

  def reply_user
    if user_unique_name = content.match(/(@[^\s]+)\s.*/)
      self.in_reply_to = user_unique_name[1]
    end
  end

end
