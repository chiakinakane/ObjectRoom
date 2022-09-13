class Idea < ApplicationRecord
   has_one_attached :image
   belongs_to :user
   has_many :idea_comments, dependent: :destroy
   has_many :favorites, dependent: :destroy
   has_many :favorited_users, through: :favorites, source: :user
  
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  
    def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end
end
