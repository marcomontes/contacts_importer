class DateValidator < ActiveModel::Validator
  def validate(record)
    begin
      Date.iso8601(record.birthdate)
    rescue => e
      record.errors.add :birthdate, e
    end
  end
end