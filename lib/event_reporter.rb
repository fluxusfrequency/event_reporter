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

class EventReporter
  def initialize
    puts "Event Reporter initialized!"
    @loader = Loader.new
    @helper = Helper.new
    @queuer = Queuer.new
    @finder = Finder.new
  end

  def run
    puts "Welcome to Event Reporter. Event Reporter helps analyze data in csv files that contain contact
    information such as names, addresses, and phone numbers. For more information, please type help."
    command = ""
    while command != "quit"
      printf "\n Enter command: "
      input = gets.chomp
      parts = input.split
      command = parts[0]
      extension = parts[1..-1].join(" ")
      case command
        when "load" then @loader.load_file(extension)
        when "help" then @helper.show_help(extension)
        when "queue" then @queuer.access_queue(extension)
        when "find" then @finder.find_data(extension)
        when "quit"
          puts "Goodbye! Event Reporter is shutting down."
        else
          puts "You have entered an unknown command. Please type 'help' for assistance."
      end
    end
  end
end