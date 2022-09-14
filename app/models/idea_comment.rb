class IdeaComment < ApplicationRecord
  belongs_to :user
  belongs_to :idea
  
  #validates :idea_comments, presence: true, length: { maximum: 300 }
end
