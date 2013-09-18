class Attendee

  def initialize (id, regdate, first_name, last_name, email_address, homephone, street, city, state, zipcode)
    @id = id
    @reg_date = regdate
    @first_name = first_name
    @last_name = last_name
    @email = email_address
    @phone = homephone
    @street = street
    @city = city
    @state = state
    @zipcode = zipcode
  end

end