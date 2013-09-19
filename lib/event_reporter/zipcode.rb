class Zipcode

  def clean(zipcode)
    if zipcode.nil?
      zipcode = "00000"
    else
      zipcode = zipcode.scan(/[0-9]/).join
      if zipcode.length != 5
        zipcode = "00000"
      end
      return zipcode
    end
  end

end
