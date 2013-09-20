require_relative 'event_reporter/attendee_list'
require_relative 'event_reporter/helper'
require_relative 'event_reporter/loader'
require_relative 'event_reporter/saver'
require_relative 'event_reporter/printer'
require 'pry'

class EventReporter

  def initialize
    @printer = Printer.new
    @parts = []
    @queue = []
    @list = []
    @verbose = false
  end

  def run
    puts "\n\t\tWelcome to Event Reporter. Event Reporter
    \t\thelps analyze data in csv files that contain contact
    \t\tinformation such as names, addresses, and phone numbers.
    \t\tFor more information, please type help."

    @verbose = true
    input = ""
    until input == "quit"
      printf "\n Enter command: "
      input = gets.chomp
      process_and_execute(input)
    end
  end

  def process_and_execute(input)
    process_input(input)
    execute_command(@parts[0])
  end

  def process_input(input)
    clean_input(input)
    parse_input(input)
  end

  def clean_input(input)
    input = input.to_s.downcase.strip
  end

  def parse_input(input)
    @parts = input.split
  end

  def execute_command(command)
    case command
      when "load"
        inspect_file_for_loading
        load(@parts[1])
      when "queue" then queue_command
      when "find" then find
      when "help" then help
      when "quit"
        puts "\n\t\tGoodbye! Event Reporter is shutting down.\n\n"
        return "Goodbye! Event Reporter is shutting down."
      else
        @printer.command_error
    end
  end

  def inspect_file_for_loading
    if @parts[1].nil?
      @parts[1] = "event_attendees.csv"
    end
  end

  def load(file)
    actually_load_file(file)
    build_attendee_list(@parts[1])
    say "Successfully loaded #{file}."
  end

  def actually_load_file(file)
    loader = Loader.new
    loader.load_file(file)
  end

  def build_attendee_list(data)
    @list = AttendeeList.new(data).list
  end

  def queue_command
    case @parts[1]
      when "count" then count
      when "clear" then clear
      when "print" then print
      when "save" then save
      else @printer.command_error
    end
  end

  def count
    current = @queue.length
    say "The queue currently has #{current} items in it."
    return current
  end

  def clear
    @queue = []
    say "The queue was successfully cleared."
    return @queue
  end

  def print
    if @parts[2] == "by"
      @printer.print_by(@queue, @parts[3])
    else
      @printer.print(@queue)
    end
  end

  def save
    saver = Saver.new
    if @parts[2].nil?
      printer.print_error_for(save)
    else
      saver.delete_if_there(@parts[2])
      saver.save(@parts[2], @queue)
    end
  end

  def find
    if @parts[1] == nil || @parts[2] == nil
      @printer.print_error_for(find)
    else
      @queue = []
      column = @parts[1].downcase.to_sym
      criteria = @parts[2..-1].join(" ").downcase
      @list.each do |attendee|
        unless attendee[column].nil?
          if attendee[column].downcase == criteria
            @queue << attendee
          end
        end
      end
      say "Found #{@queue.length} #{@parts[1]}(s) matching #{@parts[2..-1].join(" ")}."
      return 0 if @queue.length == 0
    end
  end

  def help
    helper = Helper.new
    case @parts[1]
      when "queue" then say helper.help_for_queue(@parts[2])
      when "find" then say helper.help_for_find
      when "load" then say helper.help_for_load
      else say helper.summarize_help
    end
  end

  def say(string)
    puts "\n\t\t#{string}" if @verbose
    return "#{string}"
  end

end
