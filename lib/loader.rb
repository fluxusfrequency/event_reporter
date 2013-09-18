require 'csv'

class Loader
  def initialize
    @contents = []
  end

  def load_file(filename)
    @contents = CSV.open(filename, headers: true, header_converters: :symbol)
    puts "\n Successfully loaded #{filename}.\n"
    return "successfully loaded #{filename}"
  end

  def contents
    @contents
  end

end
