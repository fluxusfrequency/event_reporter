require 'minitest'
require 'minitest/autorun'
require_relative '../lib/event_reporter.rb'

class PrintingTest < MiniTest::Test
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

  def test_responds_to_find_by_another_first_name
    skip
    reporter.find("first_name", "Mary")
    #???
  end

 def test_responds_to_queue_print
   skip
   assert_equal '', reporter.queue_print
 end

  def test_responds_to_queue_print_by_last_name
    skip
    assert_equal '', reporter.queue_print(last_name)
    assert_equal 16, reporter.queue_count
  end


end