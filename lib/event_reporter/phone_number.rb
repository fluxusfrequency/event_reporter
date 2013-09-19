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


# class Zipcode

#   def clean(zipcode)
#     if zipcode.nil?
#       zipcode = "00000"
#     else
#       zipcode = zipcode.scan(/[0-9]/).join
#       if zipcode.length != 5
#         zipcode = "00000"
#       end
#       return zipcode
#     end
#   end

# end
