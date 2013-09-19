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
require_relative 'event_reporter/saver'

class EventReporter
  attr_accessor :helper, :loader

  def initialize
    @loader = Loader.new
    @saver = Saver.new
    @parts = []
    @queue = []
    @list = []
  end

  def run
    puts "
            Welcome to Event Reporter. Event Reporter helps analyze data in csv files that contain contact
            information such as names, addresses, and phone numbers. For more information, please type help.
    "
    input = ""
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
        return "Goodbye! Event Reporter is shutting down."
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
    loader.load_file(@parts[1])
    puts "\n Successfully loaded #{@parts[1]}.\n"
    build_attendee_list(@parts[1])
    return "successfully loaded #{@parts[1]}"
  end

  def build_attendee_list(data)
    @list = AttendeeList.new(data).list
  end

  def queue
    case @parts[1]
      when "count"
        puts "\nThe queue currently has #{count} items in it."
        return count
      when "clear"
        clear
        puts "\n The queue was cleared."
        return @queue
      when "print"
        if @parts[2] == "by"
          print_by
        else
          print
        end
      when "save"
        if @parts[2].nil?
          puts "Please enter a filename to save to. Type 'help queue save' for more information."
        else
          #create an array of data from each attendee in the queue
          #pass the data to the saver object and call save on it
          #creating a new row between each piece of data
          @saver.save(@parts[2], @queue)
        end
      else command_error
    end
  end

  def find
    if @parts[1] == nil || @parts[2] == nil
      puts "\nPlease enter a column and criteria to find by. Type 'help find' for help."
    else
      column = @parts[1].downcase.to_sym
      criteria = @parts[2..-1].join(" ").downcase
      @list.each do |attendee|
        unless attendee[column].nil?
          if attendee[column].downcase == criteria
            @queue << attendee
          end
        end
      end
      puts "\nFound #{count} #{@parts[1]}(s) matching #{@parts[2..-1].join(" ")}."
      return 0 if count == 0
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

#create a class for these
  def print
    @queue.each do |item|
      puts "#{item}"
    end
    if count == 0
      puts "\nPrint was unsuccessful, because the queue was empty. Try running a 'find' command first."
      return ''
    else
      puts "\nSuccessfully printed #{count} queue items."
      return "successfully printed #{count} queue items"
    end
  end

  def print_by
    @queue = @queue.sort_by {|attendee| attendee[@parts[3].downcase.to_sym]}
    @queue.each do |item|
      puts "#{item}"
    end
    puts "\nSuccessfully printed #{count} queue items by #{@parts[3]}."
    return "successfully printed #{count} queue items by #{@parts[3]}"
  end

end
