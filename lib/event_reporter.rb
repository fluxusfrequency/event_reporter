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

require_relative 'event_reporter/attendee_list'
require_relative 'event_reporter/helper'
require_relative 'event_reporter/loader'
require_relative 'event_reporter/saver'
require_relative 'event_reporter/printer'

class EventReporter

  def initialize
    @parts = []
    @queue = []
    @list = []
  end

  def run
    puts "\n\t\tWelcome to Event Reporter. Event Reporter
    \t\thelps analyze data in csv files that contain contact
    \t\tinformation such as names, addresses, and phone numbers.
    \t\tFor more information, please type help."

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
        puts "\n\t\tGoodbye! Event Reporter is shutting down.\n\n"
        return "Goodbye! Event Reporter is shutting down."
      else
        command_error
    end
  end

  def command_error
    puts "\n\t\tSorry, EventReporter couldn't recognize your command.
    \t\tPlease type 'help' if you need assistance."
  end

  def load
    loader = Loader.new
    if @parts[1].nil?
      @parts[1] = "event_attendees.csv"
    end
    loader.load_file(@parts[1])
    puts "\n\t\tSuccessfully loaded #{@parts[1]}.\n"
    build_attendee_list(@parts[1])
    return "successfully loaded #{@parts[1]}"
  end

  def build_attendee_list(data)
    @list = AttendeeList.new(data).list
  end

  def queue
    case @parts[1]
      when "count" then count
      when "clear" then clear
      when "print" then print
      when "save" then save
      else command_error
    end
  end

  def count
    current = @queue.length
    puts "\n\t\tThe queue currently has #{current} items in it."
    return current
  end

  def clear
    @queue = []
    puts "\n\t\tThe queue was successfully cleared."
    @queue
  end

  def find
    if @parts[1] == nil || @parts[2] == nil
      puts "\n\t\tPlease enter a column and criteria to find by. Type 'help find' for help."
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
      puts "\n\t\tFound #{count} #{@parts[1]}(s) matching #{@parts[2..-1].join(" ")}."
      return 0 if count == 0
    end
  end

  def help
    helper = Helper.new
    case @parts[1]
      when "queue" then helper.help_for_queue(@parts[2])
      when "find" then helper.help_for_find
      when "load" then helper.help_for_load
      else helper.help_summary
    end
  end

  def print
    printer = Printer.new
    if @parts[2] == "by"
      printer.print_by(@queue, @parts[3])
    else
      printer.print(@queue)
    end
  end

#create a class for these
  # def print
  #   if @parts[2] == "by"
  #     printer.print_by
  #   else
  #     @queue.each do |item|
  #       puts "#{item}"
  #     end
  #     if count == 0
  #       puts "\n\t\tPrint was unsuccessful because the queue was empty. Try running a 'find' command first."
  #       return ''
  #     else
  #       puts "\n\t\tSuccessfully printed #{count} queue items."
  #       return "successfully printed #{count} queue items"
  #     end
  #   end
  # end

  # def print_by(queue)
  #   @queue = @queue.sort_by {|attendee| attendee[@parts[3].downcase.to_sym]}
  #   @queue.each do |item|
  #     puts "#{item}"
  #   end
  #   if count == 0
  #     puts "\n\t\tPrint was unsuccessful because the queue was empty. Try running a 'find' command first."
  #     return ''
  #   else
  #     puts "\n\t\tSuccessfully printed #{count} queue items by #{@parts[3]}."
  #     return "successfully printed #{count} queue items by #{@parts[3]}"
  #   end
  # end

  def save
    saver = Saver.new
    if @parts[2].nil?
      puts "\n\t\tPlease enter a filename to save to. Type 'help queue save' for more information."
    else
      saver.save(@parts[2], @queue)
    end
  end

end
