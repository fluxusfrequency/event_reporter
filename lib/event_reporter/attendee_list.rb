require_relative 'loader'
require_relative 'zipcode'
require_relative 'phone'

class AttendeeList
  attr_reader :list

  def initialize(file)
    @data = Loader.load_file(file)
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
        :phone => Phone.clean(row[:homephone]),
        :street => row[:street],
        :city => row[:city],
        :state => row[:state],
        :zipcode => Zipcode.clean(row[:zipcode])
      }
    end
  end

end
