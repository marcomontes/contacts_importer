class InvalidContact < ApplicationRecord
  belongs_to :csv_file
  paginates_per 10
end
