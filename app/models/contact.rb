class Contact < ApplicationRecord  
  NAME_REGEX  = /\A[a-zA-Z\s\-]+\z/
  PHONE_REGEX = /(\(\+\d{2}\)\s\d{3}\-\d{3}\-\d{2}\-\d{2}\z|\(\+\d{2}\)\s\d{3}\s\d{3}\s\d{2}\s\d{2}\z)/
  
  belongs_to :csv_file
  
  validates :name,  format: { with: NAME_REGEX, message: "only allows letters and -" } # Test Regex: https://rubular.com/r/o1xYlN995zu1DY
  validates :phone, format: { with: PHONE_REGEX, message: "has an invalid format. Must be (+00) 000 000 00 00 or  (+00) 000-000-00-00" } # Test Regex: https://rubular.com/r/uR58RiuL3mlwvD
  validates :name, :birthdate_str, :birthdate_str, :phone, :address, :cc_franchise, :cc_number, :cc_last_four, :email, presence: true
  validates_with DateValidator, fields: [:birthdate_str]

  paginates_per 10

end
