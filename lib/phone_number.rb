class PhoneNumber
  attr_accessor :phone

  def initialize(phone)
    @phone = phone
  end

  def clean
    if @phone
      @phone = @phone.scan(/[0-9]/).join
      if @phone.length == 11 && @phone.start_with?("1")
        @phone = @phone[1..-1]
      end
      if @phone.length != 10
        @phone = "0000000000"
      end
      return @phone
    end
  end

end
