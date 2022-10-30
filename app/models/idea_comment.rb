class IdeaComment < ApplicationRecord
  belongs_to :user
  belongs_to :idea
  
  validates :comment, presence: true

end
