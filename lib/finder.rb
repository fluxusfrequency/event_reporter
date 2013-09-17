require_relative './loader.rb'

class Finder
  def initialize
    @loader = Loader.new
  end

  def find_by(type, argument)
    case type
    when "first_name"
      find_first_name(argument)
    when "last_name"
      find_last_name(argument)
    when "city"
      find_city(argument)
    when "state"
      find_state(argument)
    when "reg_date"
      find_reg_date(argument)
    when "home_phone"
      find_home_phone(argument)
    else
      puts "Couldn't find any data matching the type #{type}."
    end
  end

  def find_first_name(first_name)

  end

  def find_last_name(last_name)
  end

  def find_city(city)
  end

  def find_state(state)
  end

  def find_reg_date(regdate)
  end

  def find_home_phone(phone_number)
  end
end
