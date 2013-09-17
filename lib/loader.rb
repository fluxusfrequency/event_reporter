require 'csv'

class Loader
  def initialize
  end

  def load_file(filename)
    contents = CSV.open(filename, headers: true, header_converters: :symbol)
    inspect_file(contents)
    return "Successfully loaded #{filename}."
  end

  def inspect_file(contents)
    contents.each do |row|
      id = row[0]
      reg_date = row[:regdate]
      first_name = row[:first_name]
      last_name = row[:last_name]
      email_address = row[:email_address]
      phone_number = row[:homephone]
      street = row[:street]
      city = row[:city]
      state = row[:state]
      zipcode = row[:zipcode]
    end
  end
end
