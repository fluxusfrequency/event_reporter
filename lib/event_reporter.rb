###################
#
# Event Reporter
# A Jumpstart Lab Project
# Written By Ben Lewis
# gSchool[1] Student
# Completed 9/19/2013
# Blog: http://fluxusfrequency.github.io
# Twitter: @fluxusfrequency
#
###################

require 'pry'
require_relative 'event_reporter/attendee'
require_relative 'event_reporter/attendee_list'
require_relative 'event_reporter/helper'
require_relative 'event_reporter/loader'

class EventReporter
  attr_accessor :helper, :loader

  def initialize
    @loader = Loader.new
    @parts = []
    @queue = []
  end

  def run
    puts "
            Welcome to Event Reporter. Event Reporter helps analyze data in csv files that contain contact
            information such as names, addresses, and phone numbers. For more information, please type help.
    "

    until input == "quit"
      printf "\n Enter command: "
      input = gets.chomp
      parse_input(input)
    end
  end

  def parse_input(input)
    @parts = input.downcase.split
    parse_command(@parts[0])
  end

  def parse_command(command)
    case command
      when "load" then load
      when "queue" then queue
      when "find" then find
      when "help" then help
      when "quit"
        puts "Goodbye! Event Reporter is shutting down."
      else
        command_error
    end
  end

  def command_error
    puts "You have entered an unknown command. Please type 'help' for assistance."
  end

  def load
    if @parts[1].nil?
      @parts[1] = "event_attendees.csv"
    end
    loader.load_file(@parts[1].to_s)
    puts "\n Successfully loaded #{@parts[1]}.\n"
    build_attendee_list
    return "successfully loaded #{@parts[1]}"
  end

  def build_attendee_list
    @list = AttendeeList.new(@parts[1].to_s)
  end

  def queue
    case @parts[1]
      when "count"
        puts "\nThe queue currently has #{count} items in it."
        return count
      when "clear"
        clear
        puts "\n The queue was cleared."
      when "print"
        if @parts[2] == "by"
          print_by
        else
          print
        end
      else command_error
    end
  end

  def find
    if @parts[1] == nil || @parts[2] == nil
      puts "\nPlease enter a column and criteria to find by. Type 'help find' for help."
    else
      @loader.contents.each do |row|
        # What is the data in the column we are looking for?
        column = row[@parts[1].to_sym].downcase
        criteria = @parts[2..-1].join(" ").downcase
        # if the column with the name that matches the type specified
        # equals the criteria that I am looking for
        if column == criteria

        # then add this attendees data to the queue
          # @queue << row
          attributes = row.to_s.split(",")
          @queue.push Attendee.new(*attributes)
        end
      end
      puts "\nSuccessfully found #{count} #{@parts[1]}(s) matching #{@parts[2..-1].join(" ")}."
    end
  end

  def help
    @helper = Helper.new
    case @parts[1]
      when "queue" then @helper.help_for_queue(@parts[2])
      when "find" then @helper.help_for_find
      when "load" then @helper.help_for_load
      else @helper.help_summary
    end
  end

  def count
    @queue.length
  end

  def clear
    @queue = []
  end

  def print
    @queue.each do |item|
      puts "#{item}"
    end
    puts "\nSuccessfully printed queue."
    return "successfully printed queue"
  end

  def print_by
    @queue = @queue.sort_by {|attendee| attendee.send(@parts[3].to_sym)}
    @queue.each do |item|
      puts "#{item}"
    end
    puts "\nSuccessfully printed queue by last name."
    return "successfully printed by last name"
  end

end
