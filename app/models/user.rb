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
  

  def active_for_authentication?
    super && (is_deleted == false)
  end
  
  # validates :last_name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  # validates :first_name, length: { minimum: 2, maximum: 20 }, uniqueness: true

  
  
  
  
   def get_profile_image#(width, height)
    (profile_image.attached?) ? profile_image : "no_image.jpg"
   
  # unless profile_image.attached?
  #   file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
  #   profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  # end
  # profile_image.variant(resize_to_limit: [width, height]).processed

  end
  #保存した後に使えるメソッド
  def name
    last_name.to_s + first_name.to_s
  end
  
  
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      #@user = User.where("last_name LIKE?", "#{word}")
      #@user = User.select('id, first_name, last_name, last_name || first_name as full_name').filter{|user| user.full_name == "#{word}"}
       @user = User.where("last_name || first_name = ?","#{word}")
    elsif search == "forward_match"
      @user = User.where("last_name || first_name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("last_name || first_name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("last_name || first_name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
  
  
  
  def favorited_by?(idea_id)
    favorites.where(idea_id: idea_id).exists?
  end
  
  def self.guest
    find_or_create_by!(first_name: "guestuser", email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.first_name = "guestuser"
      user.last_name = "❤︎"
      #存在するカラム名じゃないと保存できない。
    end
  end
end
