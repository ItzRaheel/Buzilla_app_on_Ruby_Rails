class Bug < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_many :reports ,dependent: :destroy
   has_one_attached :file
   before_validation :file_validation , on: :create

  # validates :file ,presence: true
  # validates :description ,length: {minimum:6, maximum:15}
  validates :name ,uniqueness: {case_sensitive: false}
  # validates :bug_status ,presence: true
  # before_validation :titleize_name
  # after_validation :log_error
  validates_with AddressValidator


  before_save :set_datetime 

  private 
     def titleize_name
      self.name = name.downcase.titleize if name.present?
      Rails.logger.info("Name titleized to #{name}")
    end
  def log_error 
    if errors.any?
      Rails.logger.error("validation faills ${errors.full_messages.join(' ,' )}")
      
    end
  end


  # validates :name,:status,presence: true



def file_validation
  return unless file.attached?

  acceptable_types = ["image/jpeg", "image/png", "image/gif"]
  
  unless acceptable_types.include?(file.content_type)
    errors.add(:file, "must be a JPEG, PNG, or GIF")
  end
end

# def file_validation 
#   return unless file.attached? 
#       content_type.include?("file/jpg", "file/png", "file/gif")

#     # errors.add(:file ,"the File must contain JPEJ PNG GIF not other ")

#   end

# def file_validation 
#   if file.attached?
#     allow_types
#   # def file_type
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
