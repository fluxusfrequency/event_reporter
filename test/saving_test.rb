require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/event_reporter.rb'

class SavingTest < MiniTest::Test
  attr_accessor :reporter

  def setup
    @reporter = EventReporter.new
    reporter.process_and_execute("load")
  end

  def test_responds_to_load_filename
    assert_equal 'Successfully loaded event_attendees.csv.', reporter.process_and_execute("load event_attendees.csv")
  end

  def test_responds_to_find_by_location
    reporter.process_and_execute("find city Salt Lake City")
    assert_equal 13, reporter.process_and_execute("queue count")
  end

  def test_responds_to_queue_print
    reporter.process_and_execute("find city Salt Lake City")
    assert "#{reporter.process_and_execute("queue print")}".end_with?("Successfully printed 13 queue items.")
  end

  # def test_responds_to_queue_save_to_filename
  #   reporter.process_and_execute("find city Salt Lake City")
  #   reporter.process_and_execute("queue save city_sample.csv")
  #   cityfile = File.open('city_sample.csv', "r")
  #   assert_equal "id,regdate,first_name,last_name,email_address,homephone,street,city,state,zipcode", cityfile.gets.chomp
  #   assert_equal "26,12/2/08 23:19,Michael,Panek,dntisler@jumpstartlab.com,8013626000,1434 Wilson Ave.,Salt Lake City,UT,84105", cityfile.gets.chomp
  # end

  # def test_responds_to_find_by_state
  #   reporter.process_and_execute("find state DC")
  #   assert_equal 236, reporter.process_and_execute("queue count")
  # end

  # def test_responds_to_queue_print_by_last_name
  #   reporter.process_and_execute("find state DC")
  #   assert_equal "successfully printed 236 queue items by last_name", reporter.process_and_execute("queue print by last_name")
  # end

  # def test_responds_to_queue_save
  #   reporter.process_and_execute("find state DC")
  #   reporter.process_and_execute("queue save state_sample.csv")
  #   statefile = File.open("state_sample.csv", "r")
  #   assert_equal "id,regdate,first_name,last_name,email_address,homephone,street,city,state,zipcode", statefile.gets.chomp
  #   assert_equal "1,11/12/08 10:47,Allison,Nguyen,arannon@jumpstartlab.com,6154385000,3155 19th St NW,Washington,DC,20010", statefile.gets.chomp
  # end

end
