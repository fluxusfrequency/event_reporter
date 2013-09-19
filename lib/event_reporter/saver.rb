require 'csv'

class Saver

  def delete_if_there(filename)
    if File.exists?(filename)
      File.delete(filename)
    end
  end

  def save(filename, data)
    file = CSV.open(filename, "w") do |row|
      row << %w(id regdate first_name last_name email_address homephone street city state zipcode)
      data.each do |attendee|
        row << [attendee[:id], attendee[:reg_date].to_s, attendee[:first_name].to_s.capitalize, attendee[:last_name].to_s.capitalize, attendee[:email].to_s, attendee[:phone].to_s, attendee[:street].to_s, attendee[:city].to_s, attendee[:state].to_s, attendee[:zipcode].to_s]
      end
    end

    puts "\n\t\tThe queue was saved to #{filename}"
  end

end
