require_relative 'event_reporter/attendee_list'
require_relative 'event_reporter/helper'
require_relative 'event_reporter/loader'
require_relative 'event_reporter/saver'
require_relative 'event_reporter/printer'
require 'pry'

class EventReporter

  def initialize
    @queue = []
    @verbose = false
  end

  def run
    @verbose = true

    say Printer.welcome_message

    input = ""
    until input == "quit"
      printf "\n Enter command: "
      input = gets.chomp
      process_and_execute(input)
    end
  end

  def process_and_execute(input)
    parts = process_input(input)
    command = parts[0]
    args = parts[1..-1]
    execute_command(command, args)
  end

  def process_input(input)
    cleaned_input = clean_input(input)
    split_input = cleaned_input.split
  end

  def clean_input(input)
    input.to_s.downcase.strip
  end

  # def parse_input(input)
  #   @parts =
  # end

  def execute_command(command, args)
    case command
      when "load"
        file = inspect_file_for_loading(args)
        load(file)
      when "queue" then queue_command(args)
      when "find" then find(args)
      when "help" then help(args)
      when "quit"
        say Printer.goodbye_message
      else
        say Printer.command_error
    end
  end

  def inspect_file_for_loading(args)
    args[0] ||= "event_attendees.csv"
  end

  def load(file)
    actually_load_file(file)
    build_attendee_list(file)
    say "Successfully loaded #{file}."
  end

  def actually_load_file(file)
    Loader.load_file(file)
  end

  def build_attendee_list(data)
    @list = AttendeeList.new(data).list
  end

  def queue_command(args)
    subcommand = args[0]
    case subcommand
      when "count" then count
      when "clear" then clear
      when "print" then print_or_print_by(args)
      when "save" then
        filename = args[1]
        save(filename)
      else say Printer.command_error
    end
  end

  def print_or_print_by(args)
    if args[1] == nil
      say Printer.print(@queue)
    elsif args[1] == "by"
      attribute = args[2]
      say Printer.print_by(@queue, attribute)
    else
      say Printer.command_error
    end
  end

  def count
    current = @queue.length
    say Printer.count_message(current)
    return current
  end

  def clear
    @queue = []
    say Printer.successful_clear_message
    return @queue
  end

  # def print
  #   if @parts[2] == "by"

  #   else

  #   end
  # end

  def save(filename)
    if filename.nil?
      say Printer.print_error_for(save)
    else
      Saver.delete_if_exists(filename)
      say Saver.save(filename, @queue)
    end
  end

  def find(args)
    attribute = args[0]
    criteria = args[1..-1].join(" ")
    if attribute == nil || criteria == nil
      say Printer.print_error_for(find)
    else
      clear
      @list ||= []
      column = attribute.downcase.to_sym
      @list.each do |attendee|
        unless attendee[column].nil?
          if attendee[column].downcase == criteria.downcase
            @queue << attendee
          end
        end
      end
      say "Found #{@queue.length} #{attribute}(s) matching #{criteria}."
      return 0 if @queue.length == 0
    end
  end

  def help(args)
    subcommand = args[0]
    extension = args[1]
    case subcommand
      when "queue" then say Helper.help_for_queue(extension)
      when "find" then say Helper.help_for_find
      when "load" then say Helper.help_for_load
      else say Helper.summarize_help
    end
  end

  def say(string)
    puts "\n\t\t#{string}" if @verbose
    return "#{string}"
  end

end
