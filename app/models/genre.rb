class Genre < ApplicationRecord
    
 has_many :ideas, dependent: :destroy
  # has_many :items
 validates:name, presence:true
   

end
