require 'csv'

class Loader
  def initialize
  end

  def load_file(filename)
    @contents = []
    @contents = CSV.open(filename, headers: true, header_converters: :symbol)
    puts "\n Successfully loaded #{filename}.\n"
    return "Successfully loaded #{filename}."
  end
end
