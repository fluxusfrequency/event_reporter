require_relative 'event_reporter/attendee_list'
require_relative 'event_reporter/helper'
require_relative 'event_reporter/loader'
require_relative 'event_reporter/saver'
require_relative 'event_reporter/printer'

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
      process_input(input)
      execute_command(@parts[0])
    end
  end

  def process_input(input)
    input = clean_input(input)
    parse_input(input)
  end

  def clean_input(input)
    input.downcase.strip
  end

  def parse_input(input)
    @parts = input.split
  end

  def execute_command(command)
    case command
      when "load"
        load(@parts[1])
        build_attendee_list(@parts[1])
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

  def load(file)
    if file.nil?
      file = "event_attendees.csv"
    end

    loader = Loader.new
    loader.load_file(file)
    say "Successfully loaded #{file}."
    return "successfully loaded #{file}"
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
    puts "\n\t\tThe queue currently has #{current} items in it."
    return current
  end

  def clear
    @queue = []
    puts "\n\t\tThe queue was successfully cleared."
    @queue
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
      puts "\n\t\tFound #{@queue.length} #{@parts[1]}(s) matching #{@parts[2..-1].join(" ")}."
      return 0 if @queue.length == 0
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

  def say(string)
    puts "\n\t\t#{string}" unless @verbose
  end

end
