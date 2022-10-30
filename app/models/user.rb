class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :ideas, dependent: :destroy
  has_one_attached :profile_image
  has_many :idea_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :idea # 非同期用
  
  # フォローをした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  
  validates :last_name, presence: true
  validates :first_name, presence: true
  
    # フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end
  
  #特定の条件のアカウントをログインさせなくする
  def active_for_authentication?
    super && (is_deleted == false)
  end
  
  # プロフィール画像の設定
   def get_profile_image#(width, height)
    (profile_image.attached?) ? profile_image : "no_image.jpg"
   end
   
    #nameの合併。保存した後に使えるメソッド
   def name
     last_name.to_s + first_name.to_s
   end
  
  
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      #開発環境の場合（本番環境で||は使えない為）
      #User.where("last_name || first_name = ?","#{word}")
      # MySQLの場合
      User.where("concat(last_name,first_name) = ?","#{word}")
    elsif search == "forward_match"
      #開発環境の場合（本番環境で||は使えない為）
      #User.where("last_name || first_name LIKE?","#{word}%")
      # MySQLの場合
      User.where("concat(last_name,first_name)  LIKE?","#{word}%")
    elsif search == "backward_match"
      #開発環境の場合（本番環境で||は使えない為）
      #User.where("last_name || first_name LIKE?","%#{word}")
      # MySQLの場合
      User.where("concat(last_name,first_name)  LIKE?","%#{word}")
    elsif search == "partial_match"
      #開発環境の場合（本番環境で||は使えない為）
      #User.where("last_name || first_name LIKE?","%#{word}%")
      # MySQLの場合
      User.where("concat(last_name,first_name)  LIKE?","%#{word}%")
    else
      User.all
    end
  end
  
  
  #いいね
  def favorited_by?(idea_id)
    favorites.where(idea_id: idea_id).exists?
  end
  
  #ゲストユーザー設定
  def self.guest
    find_or_create_by!(first_name: "guestuser", email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.first_name = "guestuser"
      user.last_name = "❤︎"
      #存在するカラム名じゃないと保存できない。
    end
  end
end
