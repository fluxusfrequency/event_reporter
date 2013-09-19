require 'pry'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/event_reporter.rb'

class SavingTest < MiniTest::Test
  attr_accessor :reporter

  def setup
    @reporter = EventReporter.new
    reporter.parse_input("load")
  end

  def test_responds_to_load_filename
    assert_equal 'successfully loaded event_attendees.csv', reporter.parse_input("load event_attendees.csv")
  end

  def test_responds_to_find_by_location
    reporter.parse_input("find city Salt Lake City")
    assert_equal 13, reporter.parse_input("queue count")
  end

  def test_responds_to_queue_print
    reporter.parse_input("find city Salt Lake City")
    assert_equal "successfully printed 13 queue items", reporter.parse_input("queue print")
  end

  def test_responds_to_queue_save_to_filename
    reporter.parse_input("find city Salt Lake City")
    reporter.parse_input("queue save city_sample.csv")
    cityfile = File.open('city_sample.csv', "r")
    assert_equal "id,regdate,first_name,last_name,email_address,homephone,street,city,state,zipcode", cityfile.gets.chomp
  end

  def test_opens_the_CSV_file_and_inspects_headers
    skip
    cityfile = File.open('../city_sample.csv', r)
    assert_equal cityfile.read, reporter.inspect_headers('../city_sample.csv')
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
