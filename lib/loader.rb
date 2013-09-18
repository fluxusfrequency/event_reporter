require 'csv'

class Loader
  def initialize
    @contents = []
  end

  def load_file(filename='event_attendees.csv')
    @contents = CSV.open(filename, headers: true, header_converters: :symbol)
    puts "\n Successfully loaded #{filename}.\n"
    return "Successfully loaded #{filename}."
  end
end
