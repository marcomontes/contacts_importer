require 'rails_helper'

RSpec.describe Contact, type: :model do
  it "is not valid without a name" do
    contact = Contact.new(name: nil)
    expect(contact).to_not be_valid
  end

  it "is not valid without a valid name" do
    contact = Contact.new(name: "Marco. Montes1")
    expect(contact).to_not be_valid
  end

  it "is not valid without a valid phone" do
    contact = Contact.new(phone: "310 527 00 00")
    expect(contact).to_not be_valid
  end

  it "is not valid without a valid date" do
    contact = Contact.new(birthdate_str: "01/10/2018")
    expect(contact).to_not be_valid
  end
end
