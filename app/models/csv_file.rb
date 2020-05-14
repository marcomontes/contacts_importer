class CsvFile < ApplicationRecord
  belongs_to :user
  has_many :contacts
  has_many :invalid_contacts
  has_one_attached :contacts_file

  after_create :create_contacts

  def contacts_file_url
    contacts_file.attachment.service_url if contacts_file.attachment
  end

  def contacts_file_name
    contacts_file.filename.to_s
  end

  private
    def create_contacts
      ContactCreator.call(self)
    end
end
