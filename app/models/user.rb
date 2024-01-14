class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many  :leaves, through: :leave_balances
  has_many  :leave_balances, dependent: :destroy

  mount_uploader :profile_pic, ProfilePicUploader
  validates :email, presence: true

  enum role: [:employee, :HR, :admin]
  after_initialize :set_default_role, :if => :new_record?

    def set_default_role
      self.role ||= :employee
    end

end
