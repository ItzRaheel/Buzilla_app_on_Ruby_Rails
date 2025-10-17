class Bug < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_many :reports ,dependent: :destroy
   has_one_attached :file
   before_validation :file_validation , on: :create

   before_validation :normal_name
  # validates :file ,presence: true
  # validates :description ,length: {minimum:6, maximum:15}
  validates :name ,uniqueness: {case_sensitive: false}
  # validates :bug_status ,presence: true
  # after_validation :log_error
  validates_with AddressValidator


  before_save :set_datetime 

  private 
     def normal_name
      self.name = name.to_s.strip
      
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


  def set_datetime

    self.date = DateTime.now 
  end


end
