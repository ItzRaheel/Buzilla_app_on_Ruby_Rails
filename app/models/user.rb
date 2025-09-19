class User < ApplicationRecord
  has_many :bugs ,dependent: :destroy
  has_many :projects ,dependent: :destroy
  after_create :send_welcome_email
  around_create :log_creation
  before_create :defult_role
  # validates :email , confirmation: true
  validates_length_of :name ,maximum: 11
  before_validation :blank_space
  validates  :name , presence:true ,uniqueness: {case_sensitive: false } ,on: :create
  validates :email ,presence: true



  # before_validation do 

  #   self.name = :email if name.blank? 
  # end






    validates :name, presence: true
  # before_validation :titleize_name
  # after_validation :log_errors

  private
  def blank_space 
    name.strip!
  end
    def log_creation
      Rails.logger.info("Creating user with email: #{email}")
      yield
      Rails.logger.info("User created with email: #{email}")
    end
    def titleize_name
      self.name = name.downcase.titleize if name.present?
      Rails.logger.info("Name titleized to #{name}")
    end

    def log_errors
      if errors.any?
        Rails.logger.error("Validation failed: #{errors.full_messages.join(', ')}")
      end
    end


  def send_welcome_email
    AuthNotificationJob.perform_later("signup", self.id)
  end

  def defult_role
    self.role = "Manger"
    # self.update(role: "Manger") if self.role.blank?
  end

  # has_many :created_projects, class_name: "Project", foreign_key: "user_id"
  # has_many :assigned_projects, class_name: "Project", foreign_key: "developer_id"

  has_many :project_bug, through: :projects,source: :bugs
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
