class Contact < ApplicationRecord  
  belongs_to :csv_file
  
  validates :name, format: { with: /\A[a-zA-Z\s\-]+\z/, message: "only allows letters and -" }
  validates_with DateValidator, fields: [:birthdate_str]

  paginates_per 10

end
