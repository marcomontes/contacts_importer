require 'csv'
require 'open-uri'
require 'bcrypt'

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
    
    contact_objects      = []
    valid_contact_objs   = []
    invalid_contact_objs = []

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
        name:          c[name],
        birthdate_str: c[birthdate],
        phone:         c[phone],
        address:       c[address],
        email:         c[email],
        cc_franchise:  franchise,
        cc_number:     cc_crypt,
        cc_last_four:  cc_nums,
        user:          @csv_file.user
      )
    end

    contact_objects.each do |c_obj|
      if c_obj.valid?
        valid_contact_objs << c_obj
      else
        invalid_contact_objs << c_obj.attributes.except("id", "birthdate").merge(error_msgs: c_obj.errors.full_messages)
      end
    end
    
    Contact.import valid_contact_objs, validate_uniqueness: true
    InvalidContact.import invalid_contact_objs
  end

  def identify_column(letter)
    positions = ('A'..'Z').each_with_index.map{|l, index| [l, index] }
    result    = positions.find {|e| e[0] == letter}
    result[1]
  end

  def find_cc_franchise(cc_number)
    # CC_TYPES defined in config/initializers/credit_card_types.rb
    brand = :unknown
    CC_TYPES.each{|k,v| brand = k if cc_number =~ v }
    return brand
  end

  def cc_last_four(cc_number)
    cc_number.to_s.last(4)
  end

  def encrypted_credit_card(cc_number)
    generate_encryption = case find_cc_franchise(cc_number)
      when :dinners
        true if cc_number.length == 14
      when :amex
        true if cc_number.length == 15
      when :visa
        true if [13,16].include?(cc_number.length)
      when :mastercard
        true if cc_number.length == 16
      when :discover
        true if cc_number.length == 16
      else
        false
      end

     generate_encryption ? BCrypt::Password.create(cc_number) : 'invalid'
  end
end
