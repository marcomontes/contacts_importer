class InvalidContact < ApplicationRecord
  belongs_to :csv_file
  belongs_to :user
  paginates_per 10
end
