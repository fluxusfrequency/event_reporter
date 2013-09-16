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
    cityfile = File.open('city_sample.csv', r)
    assert_equal cityfile.read, reporter.queue_save_to('city_sample.csv')
  end

  def test_opens_the_CSV_file_and_inspects_headers
    skip
    cityfile = File.open('city_sample.csv', r)
    assert_equal cityfile.read, reporter.inspect_headers('city_sample.csv')
  end

  def test_responds_to_find_by_state
    skip
    assert_equal "DC", reporter.find("state", "DC")
  end

  def test_responds_to_queue_print_by_last_name
    skip
    assert_equal '', reporter.queue_print(last_name)
  end

  def test_responds_to_queue_save
    skip
    assert_equal '', reporter.queue_save('state_sample.csv')
  end

  def test_opens_a_saved_CSV_file_and_inspects_headers
    skip
    cityfile = File.open('state_sample.csv', r)
    assert_equal cityfile.read, reporter.inspect_headers('state_sample.csv')
  end

end