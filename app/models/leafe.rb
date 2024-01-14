class Leafe < ApplicationRecord
    belongs_to :leave_balance

    mount_uploader :attachment, AttachmentUploader
    validates :name, presence: true
end
