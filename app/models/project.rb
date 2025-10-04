class Project < ApplicationRecord
     belongs_to :user
     has_many :bugs, dependent: :destroy
     validates :name ,presence: true, uniqueness: {case_sensitive: false},format:{with: /\A[a-zA-Z0-4]+\z/, message: "only allow this Word"},length: {minimum:3, maximum:20}
     validates_each  :description do |record ,attr, value|
          record.errors.add(attr,"Must start with Capital letter ") if /\A[[:lower:]]/.match?(value) 
     end
     validates_with AddressValidator

     
#        belongs_to :creator, class_name: "User", foreign_key: "user_id"
#   belongs_to :developer, class_name: "User", optional: true
     
end

