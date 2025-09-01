class User < ApplicationRecord
  has_many :bugs ,dependent: :destroy
  has_many :projects ,dependent: :destroy
  after_create :send_welcome_email
  after_create :defult_role

  private

  def send_welcome_email
    AuthNotificationJob.perform_later("signup", self.id)
  end

  def defult_role
    self.update(role: "Manger") if self.role.blank?
  end

  # has_many :created_projects, class_name: "Project", foreign_key: "user_id"
  # has_many :assigned_projects, class_name: "Project", foreign_key: "developer_id"

  has_many :project_bug, through: :projects,source: :bugs
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
