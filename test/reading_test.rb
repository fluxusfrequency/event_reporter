require 'minitest'
require 'minitest/autorun'
require_relative '../lib/event_reporter.rb'

class ReadingTest < MiniTest::Test
  attr_accessor :reporter

  def setup
    @reporter = EventReporter.new
  end

end