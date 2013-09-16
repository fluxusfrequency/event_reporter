require 'minitest'
require 'minitest/autorun'
require_relative '../lib/event_reporter.rb'

class HappyPathTest < MiniTest::Test
  attr_accessor :reporter

  def setup
    @reporter = EventReporter.new
  end

  def test_responds_to_load_filename
    skip
    assert_equal 'Successfully loaded event_attendees.csv.', reporter.load("event_attendees.csv")
  end

  def test_queue_count_defaults_to_zero
    skip
    assert_equal 0, queue_count
  end

  def test_responds_to_find_by_first_name
    skip
    reporter.find("first_name", "John")
    assert_equal 63, reporter.queue_count
  end

  def test_responds_to_queue_clear
    skip
    reporter.queue_clear
    assert_equal 0, reporter.queue_count
  end

  def test_responds_to_help
    skip
    assert_equal '', reporter.help
  end

  def test_responds_to_help_queue_count_command
    skip
    assert_equal '', reporter.help(queue_count)
  end

  def test_responds_to_help_queue_print_command
    skip
    assert_equal '', reporter.help(queue_print)
  end

end