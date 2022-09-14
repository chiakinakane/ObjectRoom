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

  
  # validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  # validates :introduction, length: { maximum: 50 }
  
  
   def get_profile_image#(width, height)
    (profile_image.attached?) ? profile_image : "no_image.jpg"
   
  # unless profile_image.attached?
  #   file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
  #   profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  # end
  # profile_image.variant(resize_to_limit: [width, height]).processed

  end

  def name
    last_name.to_s + first_name.to_s
  end
  #保存した後に使えるメソッド
  
  def favorited_by?(idea_id)
    favorites.where(idea_id: idea_id).exists?
  end
  
  def self.guest
    find_or_create_by!(first_name: "guestuser", email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.first_name = "guestuser"
      #存在するからむ名じゃないと保存できない。
    end
  end
end
