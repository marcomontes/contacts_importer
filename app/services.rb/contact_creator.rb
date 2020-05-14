require 'csv'
require 'open-uri'

class ContactCreator < ApplicationService
  attr_reader :csv_file

  def initialize(csv_file)
    @csv_file = csv_file
    @file_url = csv_file.contacts_file_url
    @columns  = csv_file.columns
  end

  def call
    csv_content     = open(@file_url)
    contacts_data   = CSV.parse(csv_content, headers: false)
    contact_objects = []

    contacts_data.each do |c|
      
      name      = identify_column(@columns["name"])
      birthdate = identify_column(@columns["birthdate"])
      phone     = identify_column(@columns["phone"])
      address   = identify_column(@columns["address"])
      email     = identify_column(@columns["email"])
      cc        = c[identify_column(@columns["cc"])]
      franchise = find_cc_franchise(cc)
      cc_crypt  = encrypted_credit_card(cc)
      cc_nums   = cc_last_four(cc)

      contact_objects << @csv_file.contacts.new(
        name:         c[name],
        birthdate:    c[birthdate],
        phone:        c[phone],
        address:      c[address],
        email:        c[email],
        cc_franchise: franchise,
        cc_number:    cc_crypt,
        cc_last_four: cc_nums
      )
    end
    Contact.import! contact_objects
  end

  def identify_column(letter)
    positions = ('A'..'Z').each_with_index.map{|l, index| [l, index] }
    result    = positions.find {|e| e[0] == letter}
    result[1]
  end

  def find_cc_franchise(cc_number)
    'VISA'
  end

  def cc_last_four(credit_card)
    credit_card.to_s.last(4)
  end

  def encrypted_credit_card(cc)
    "xyz"
  end
end


#require 'csv'
#require 'open-uri'

#csv_content = open(file.contacts_file_url)
#contacts = CSV.parse(csv_content, headers: false)


# Contact.create(name: c[0], birthdate: c[1], phone: c[2], address: c[3], cc_franchise: 'VISA', cc_number: c[4], cc_last_four: c[4].last(2), email: c[5],csv_file: csv_file)