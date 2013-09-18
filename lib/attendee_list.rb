require_relative 'loader'

class AttendeeList
  def initialize(file)
    @loader = Loader.new
    @attendees = @loader.load_file(file)
    populate_list
  end

  def populate_list
    @list = @attendees.collect do |row|
      attendee = {
        :id => row[0],
        :reg_date => row[:regdate],
        :first_name => row[:first_name],
        :last_name => row[:last_name],
        :email => row[:email_address],
        :phone => row[:phone],
        :street => row[:street],
        :city => row[:city],
        :state => row[:state],
        :zipcode => row[:zipcode]
      }
    end
  end

end
