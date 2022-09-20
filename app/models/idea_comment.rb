class IdeaComment < ApplicationRecord
  belongs_to :user
  belongs_to :idea
  # validates :title, presence: true
  # validates :body, presence: true, length: { maximum: 200 }
  
  #validates :idea_comments, presence: true, length: { maximum: 300 }
end
