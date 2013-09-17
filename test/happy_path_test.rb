require 'minitest'
require 'minitest/autorun'
require_relative '../lib/event_reporter.rb'

class HappyPathTest < MiniTest::Test
  attr_accessor :reporter

  def setup
    @reporter = EventReporter.new
    reporter.load_file('event_attendees.csv')
  end

  def test_responds_to_load_filename
    assert_equal 'Successfully loaded event_attendees.csv.', reporter.parse_input("load event_attendees.csv")
  end

  def test_queue_count_defaults_to_zero
    assert_equal 0, reporter.queue_count
  end

  def test_responds_to_find_by_first_name
    reporter.find_by(:first_name, "John")
    assert_equal 63, reporter.queue_count
  end

  def test_responds_to_queue_clear
    reporter.queue_clear
    assert_equal 0, reporter.queue_count
  end

  def test_responds_to_help
    assert_equal "responded to help", reporter.parse_input("help")
  end

  def test_responds_to_help_queue_count_command
    assert_equal "responded to help queue count", reporter.parse_input("help queue count")
  end

  def test_responds_to_help_queue_print_command
    assert_equal "responded to help queue print", reporter.parse_input("help queue print")
  end

end