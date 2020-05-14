class CsvFile < ApplicationRecord
  belongs_to :user
  has_many   :contacts

  has_one_attached :contacts_file


  def contacts_file_url
    if self.contacts_file.attachment
      self.contacts_file.attachment.service_url
    end
  end

  def contacts_file_name
    self.contacts_file.filename.to_s
  end
end
