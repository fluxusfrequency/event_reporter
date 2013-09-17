=begin
require 'minitest'
require 'minitest/autorun'
require_relative '../lib/event_reporter.rb'

class EventReporterTest < MiniTest::Test
  attr_accessor :reporter

  def setup
    @reporter = EventReporter.new
  end

end

#assert
#assert_equal
#assert_inlcudes
#assert_nil
#assert_raises
=end