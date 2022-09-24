class Genre < ApplicationRecord
    
 has_many :ideas, dependent: :destroy
 validates:name, presence:true
   

end
