class CsvFile < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :contacts
  has_many :invalid_contacts
  has_one_attached :contacts_file

  after_create :create_contacts
  after_create :set_final_states

  paginates_per 10

  aasm do
    state :waiting, initial: true
    state :processing
    state :failed
    state :finished

    event :uploaded do
      transitions from: [:waiting], to: :processing
    end
    event :not_processed do
      transitions from: [:processing], to: :failed
    end
    event :processed do
      transitions from: [:failed, :processing], to: :finished
    end
  end

  def contacts_file_url
    contacts_file.attachment.service_url if contacts_file.attachment
  end

  def contacts_file_name
    contacts_file.filename.to_s
  end

  private
    def create_contacts
      self.uploaded!
      ContactCreator.call(self)
    end

    def set_final_states
      self.reload
      self.not_processed! if self.may_not_processed? && self.invalid_contacts.count >= 1 
      self.processed!     if self.may_processed? && self.contacts.count >= 1 
    end
end
