class Address < ApplicationRecord
  belongs_to :user
  validates :user_id,  presence: true
  validates :line_1,   presence: true
  validates :town,     presence: true
  validates :county,   presence: true
  VALID_POSTCODE_REGEX = /\s*((GIR\s*0AA)|((([A-PR-UWYZ][0-9]{1,2})|(([A-PR-UWYZ][A-HK-Y][0-9]{1,2})|(([A-PR-UWYZ][0-9][A-HJKSTUW])|([A-PR-UWYZ][A-HK-Y][0-9][ABEHMNPRVWXY]))))\s*[0-9][ABD-HJLNP-UW-Z]{2}))\s*/i
  validates :postcode, presence: true,
                       format: { with: VALID_POSTCODE_REGEX }
end
