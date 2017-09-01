class User < ActiveRecord::Base
  #micropostsテーブルとの依存関係の設定、
  #dependentでユーザーが破棄されたら、依存関係にあるマイクロソフトも破棄
  has_many :microposts, dependent: :destroy
  # foreign_keyで外部キーを明示的に指名する
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  #reverse_relationshipの定義決め
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name: "Relationship",
                                   dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  has_many :relationfavorites, foreign_key: "favorite_id", dependent: :destroy
  has_many :likes

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  def feed(user)
    Micropost.from_users_followed_by(self).including_replies(user)
  end

  def feed_message(user)
    Micropost.from_message(user)
  end

#フォローする相手が存在しているか確認
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

#フォローする
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

#フォロー解除
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end




  # 記憶トークンの作成
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  #記憶トークンの暗号化
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end

end
