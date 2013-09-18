class PhoneNumber
  attr_accessor :phone_number

  def initialize(phone_number)
    @phone_number = phone_number
  end

  def clean_phone_number
    if @phone_number
      @phone_number = @phone_number.scan(/[0-9]/).join
      if @phone_number.length == 11 && @phone_number.start_with?("1")
        @phone_number = @phone_number[1..-1]
      end
      if @phone_number.length != 10
        @phone_number = "0000000000"
      end
      return @phone_number
    end
  end

end