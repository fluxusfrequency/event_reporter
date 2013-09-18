class Zipcode
  attr_accessor :zipcode

  def initialize(zipcode)
    @zipcode = zipcode
  end

  def clean_zipcode
    if @zipcode
      @zipcode = @zipcode.scan(/[0-9]/).join
      if @zipcode.length != 5
        @zipcode = "00000"
      end

      return @zipcode
    end
  end

end