class Contact < ApplicationRecord
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
  validates :message, presence: true
end
