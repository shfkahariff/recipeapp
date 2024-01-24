class User < ApplicationRecord
  after_create :generate_public_id
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many  :leave_balances, dependent: :destroy
  has_many  :leaves, through: :leave_balances, dependent: :destroy
  
  has_many :notifications, as: :recipient, dependent: :destroy

  mount_uploader :profile_pic, ProfilePicUploader
  validates :email, presence: true

  enum role: [:employee, :HR, :admin]
  after_initialize :set_default_role, :if => :new_record?

    def set_default_role
      self.role ||= :employee
    end

  private
    def generate_public_id
      self.public_id = "EMP#{sprintf '%04d', self.id}"
      self.save
    end

end
