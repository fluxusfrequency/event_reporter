class Phone

  def clean(phone)
    if phone.nil?
      phone = "0000000000"
    else
      phone = phone.scan(/[0-9]/).join
      if phone.length == 11 && phone.start_with?("1")
        phone = phone[1..-1]
      elsif phone.length != 10
        phone = "0000000000"
      else
        return phone
      end
    end
  end

end
