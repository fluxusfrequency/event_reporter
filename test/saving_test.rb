require 'minitest'
require 'minitest/autorun'
require_relative '../lib/event_reporter.rb'

class SavingTest < MiniTest::Test
  attr_accessor :reporter

  def setup
    @reporter = EventReporter.new
  end

  def test_responds_to_load_filename
    skip
    assert_equal 'Successfully loaded event_attendees.csv.', reporter.load("event_attendees.csv")
  end

  def test_responds_to_find_by_by_location
    skip
    reporter.find("city", "Salt Lake City")
  end

  def test_responds_to_queue_print
    skip
    assert_equal 13, reporter.queue_print.length
  end

  def test_responds_to_queue_save_to_filename
    skip
    cityfile = File.open('city_sample.csv', w)
    assert_equal cityfile.read, reporter.queue_save_to('city_sample.csv')
  end

end