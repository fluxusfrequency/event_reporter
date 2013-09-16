require 'minitest'
require_relative '../lib/event_reporter.rb'

class EventReporterTest < MiniTest::Unit::TestCase
  attr_accessor :reporter

  def setup
    @reporter = EventReporter.new
  end

  def test_displays_a_command_line
    assert_equal '', reporter.run
  end

  def test_responds_to_load_filename
    skip
    assert_equal 'Successfully loaded event_attendees.csv.', reporter.load("event_attendees.csv")
  end

  def test_responds_to_help
    skip
    assert_equal '', reporter.help
  end

  def test_responds_to_help_command
    skip
    assert_equal '', reporter.help(queue_count)
  end

  def test_queue_count_defaults_to_zero
    skip
    assert_equal 0, queue_count
  end

  def test_responds_to_queue_clear
    skip
    reporter.queue_clear
    assert_equal 0, reporter.queue_count
  end

  def test_responds_to_find_by_by_name
    skip
    reporter.find("first_name", "John")
    assert_equal 63, reporter.queue_count
  end

  def test_responds_to_find_by_by_location
    skip
    reporter.find("city", "Salt Lake City")
  end

  def test_responds_to_queue_print
    skip
    saltlake = reporter.queue_print
    assert_equal 13, saltlake.length
  end

  def test_responds_to_queue_save_to_filename
    skip
    cityfile = File.open('city_sample.csv', r)
    assert_equal cityfile.read, reporter.queue_save_to('city_sample.csv')
  end

  def test_responds_to_queue_print_by_attribute
    skip
    assert_equal '', reporter.queue_print_by(attribute)
  end


end