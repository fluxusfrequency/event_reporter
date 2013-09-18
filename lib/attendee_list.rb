require_relative 'attendee'
require_relative 'loader'

class AttendeeList
  def initialize
    @loader = Loader.new
    @attendees =
  end
end
