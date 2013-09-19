require_relative 'loader'

class AttendeeList
  attr_reader :list

  def initialize(file)
    @loader = Loader.new
    @data = @loader.load_file(file)
    @list = []
    populate_list
  end

  def populate_list
    @list = @data.collect do |row|
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
