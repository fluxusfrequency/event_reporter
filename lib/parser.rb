class Parser
  def initialize
    @parts = []
    @contents = []
  end

  def clean_input(input)
    input = input.downcase
  end

  def parse_input(input)
    clean_input(input)
    @parts = input.split
    @command = @parts[0]
    @extension = @parts[1]
    @subcommand = @parts[2]
    @find_criteria = @parts[2..-1]
    @mcguffin = @parts[3..-1]
    parse_command(@command)
  end

  def parse_command(command)
    case command
      when "load"
        if @parts[1].nil?
          @parts[1] = "event_attendees.csv"
        end
        load_file(@parts[1].to_s)
      when "help" then help_parse
      when "queue" then queue_parse
      when "find" then find_parse
      when "quit"
        puts "Goodbye! Event Reporter is shutting down."
      else
        command_error
    end
  end

  def command_error
    puts "You have entered an unknown command. Please type 'help' for assistance."
  end

end