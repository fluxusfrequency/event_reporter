require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/event_reporter.rb'

class PrintingTest < MiniTest::Test
  attr_accessor :reporter

  def setup
    @reporter = EventReporter.new
    reporter.parse_input("load")
  end

  def test_responds_to_load_filename
    assert_equal 'successfully loaded event_attendees.csv', reporter.parse_input("load event_attendees.csv")
  end

  def test_queue_count_defaults_to_zero
    assert_equal 0, reporter.parse_input("queue count")
  end

  def test_responds_to_find_by_first_name
    reporter.parse_input("find first_name John")
    assert_equal 63, reporter.parse_input("queue count")
  end

  def test_responds_to_find_by_another_first_name
    reporter.parse_input("find first_name Mary")
    assert_equal 16, reporter.parse_input("queue count")
  end

  def test_responds_to_queue_print
    reporter.parse_input("find first_name Mary")
    assert_equal "successfully printed 16 queue items", reporter.parse_input("queue print")
  end

  def test_responds_to_queue_print_by_last_name
    reporter.parse_input("find first_name Mary")
    assert_equal "successfully printed 16 queue items by last_name", reporter.parse_input("queue print by last_name")
    assert_equal 16, reporter.parse_input("queue count")
  end

end

