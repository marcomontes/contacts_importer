class Contact < ApplicationRecord
  # :birthdate is stored as a string in order to use a custom validator and allow only certain formats
  
  belongs_to :csv_file
  
  validates :name, format: { with: /\A[a-zA-Z\s\-]+\z/, message: "only allows letters and -" }
  validates_with DateValidator, fields: [:birthdate]

  paginates_per 10

end
