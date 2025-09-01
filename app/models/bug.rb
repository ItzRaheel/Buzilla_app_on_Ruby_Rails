class Bug < ApplicationRecord
  belongs_to :project
  belongs_to :user
   has_one_attached :file
  validates :file ,presence: true
  validates :name,presence: true ,uniqueness: {case_sensitive: false}
  validates :bug_status ,presence: true
  


  # validates :name,:status,presence: true

  before_save :set_datetime 

  # def file_type
  #   return unless file.attached?
  #   allowed_types = ["image/jpg","image/gif","image/png"]
  #   unless allowed_types.include?(file.content_type)
  #     errors.add(:file,"the file must be a jpeg or gif or png")
  #   end

  # end
#   def only_priority_change?(changes)
#   # Check if only priority is being changed
#   changes.keys == ['priority'] || 
#   (changes.keys.size == 1 && changes.key?('priority'))
# end
# app/models/bug.rb

  def set_datetime

    self.date = DateTime.now 
  end


end
