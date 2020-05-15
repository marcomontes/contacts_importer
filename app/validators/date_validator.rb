class DateValidator < ActiveModel::Validator
  def validate(record)
    begin
      record.birthdate = Date.iso8601(record.birthdate_str)
    rescue => e
      record.errors.add :birthdate, e
    end
  end
end
