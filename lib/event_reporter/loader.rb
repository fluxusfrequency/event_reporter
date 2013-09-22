require 'csv'

class Loader

  attr_reader :contents

  def initialize
    @contents = []
  end

  def load_file(filename)
    @contents = CSV.open(filename, headers: true, header_converters: :symbol)
  end

end
