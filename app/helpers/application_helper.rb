module ApplicationHelper
  def files_counter
    current_user.csv_files.count
  end

  def contacts_counter
    current_user.contacts.count
  end

  def sheet_columns
    ('A'..'Z').map{|l| [l,l]}
  end
end

