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

require 'csv'
require_relative 'finder.rb'
require_relative 'helper.rb'
require_relative 'loader.rb'
require_relative 'queuer.rb'
require_relative 'parses.rb'

class EventReporter
  def initialize
    @command = ""
    @contents = []
    @finder = Finder.new
    @helper = Helper.new
    @loader = Loader.new
    @parser = Parser.new
    @queuer = Queuer.new
  end

  def run
    puts "
            Welcome to Event Reporter. Event Reporter helps analyze data in csv files that contain contact
            information such as names, addresses, and phone numbers. For more information, please type help.
    "

    while @command != "quit"
      printf "\n Enter command: "
      input = gets.chomp
      parser.parse_input(input)
    end
  end

end
