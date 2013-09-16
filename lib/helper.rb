class Helper
  def initialize
  end

  def show_help(command_type = "default")
    command_parts = command_type.downcase.split
    command_for_execute = command_parts[0]
    arguments_for_command = command_parts[1..-1].join(" ")
    case command_for_execute
      when "queue" then queue_help(arguments_for_command || "default")
      when "find" then find_help(arguments_for_command || "default")
      when "load" then load_help(arguments_for_command || "default")
      else
        default_help
      end
  end

  def queue_help
  end

  def find_help
  end

  def default_help
  end

  def load_help
  end

end
