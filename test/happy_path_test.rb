require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/event_reporter.rb'

class HappyPathTest < MiniTest::Test
  attr_accessor :reporter

  def setup
    @reporter = EventReporter.new
    reporter.process_and_execute("load")
  end

  def test_responds_to_load_filename
    assert_equal 'Successfully loaded event_attendees.csv.', reporter.process_and_execute("load event_attendees.csv")
  end

  def test_responds_to_load_filename_nil_with_a_default_file
    assert_equal 'Successfully loaded event_attendees.csv.', reporter.process_and_execute("load")
  end

  def test_queue_count_defaults_to_zero
    assert_equal 0, reporter.process_and_execute("queue count")
  end

  # def test_responds_to_find_by_first_name
  #   reporter.process_and_execute("find first_name John")
  #   assert_equal 63, reporter.process_and_execute("queue count")
  #   reporter.process_and_execute("queue print")
  # end

  # def test_responds_to_queue_clear
  #   reporter.process_and_execute("queue clear")
  #   assert_equal 0, reporter.process_and_execute("queue count")
  # end

  # def test_responds_to_help
  #   assert_equal "responded to help", reporter.process_and_execute("help")
  # end

  # def test_responds_to_help_queue_count_command
  #   assert_equal "responded to help queue count", reporter.process_and_execute("help queue count")
  # end

  # def test_responds_to_help_queue_print_command
  #   assert_equal "responded to help queue print", reporter.process_and_execute("help queue print")
  # end

end
