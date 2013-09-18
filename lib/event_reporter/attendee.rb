require_relative '../phone_number.rb'
require_relative '../zipcode.rb'

class Attendee
  attr_accessor :id, :reg_date, :first_name, :last_name, :email, :phone_number, :street, :city, :state, :zipcode

  def initialize (id, regdate, first_name, last_name, email_address, homephone, street, city, state, zipcode)
    @id = id
    @reg_date = regdate
    @first_name = first_name
    @last_name = last_name
    @email = email_address
    @phone = PhoneNumber.new(homephone)
    @street = street
    @city = city
    @state = state
    @zipcode = Zipcode.new(zipcode)
  end

end
