class Project < ApplicationRecord
     belongs_to :user
     has_many :bugs, dependent: :destroy
#        belongs_to :creator, class_name: "User", foreign_key: "user_id"
#   belongs_to :developer, class_name: "User", optional: true
     
end