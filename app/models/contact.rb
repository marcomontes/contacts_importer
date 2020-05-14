class Contact < ApplicationRecord
  belongs_to :csv_file
  
  validates :name, format: { with: /\A[a-zA-Z\s\-]+\z/, message: "only allows letters and -" }
  
  paginates_per 10
end
