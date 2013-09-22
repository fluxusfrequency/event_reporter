class Printer

  def self.print(queue)
    if queue.length == 0
      empty_queue_error_message
    else
      create_tabs + print_lines(queue) + successful_print_message(queue.length)
    end
  end

  def self.print_by(queue, param)
    if queue.length == 0
      empty_queue_error_message
    else
      param = clean_param_for_sort(param)
      queue = queue.sort_by {|attendee| attendee[param]}
      create_tabs + print_lines(queue) + successful_print_by_message(queue.length, param)
    end
  end

  def self.clean_param_for_sort(param)
    param.downcase.to_sym
  end

  def self.create_tabs
    "--------------------------------------------------------------------------------------------------------------------------------------------\nATTENDEE ID   REG DATE      FIRST NAME    LAST NAME     EMAIL         PHONE         ADDRESS       CITY          STATE         ZIPCODE       \n--------------------------------------------------------------------------------------------------------------------------------------------"
  end


  def self.print_lines(queue)
    ljusted_values = []
    queue.each do |attendee|
      attendee.values.each do |value|
        ljusted_values << clean_attendee_value(value)
      end
    end
    ljusted_values.join("") + "\n" + successful_print_message(queue.length)
  end

  def self.clean_attendee_value(value)
    value ||= " "
    value = value[0..12]
    lvalue = value.ljust(14, " ")
    lvalue
  end

  def self.print_error_for(command)
    case command
      when "save" then save_error
      when "find" then find_error
      when "print" then print_error
      else command_error
    end
  end

  def self.save_error
    "Please enter a filename to save to. Type 'help queue save' for more information."
  end

  def self.find_error
    "Please enter a column and criteria to find by. Type 'help find' for help."
  end

  def self.print_error
    "Sorry, there was a problem with your command. Type 'help queue print' for help."
  end

  def self.command_error
    "Sorry, EventReporter couldn't recognize your command.\n\t\tPlease type 'help' if you need assistance."
  end

  def self.welcome_message
    "Welcome to Event Reporter. Event Reporter
     \t\thelps analyze data in csv files that contain contact
     \t\tinformation such as names, addresses, and phone numbers.
     \t\tFor more information, please type help."
  end

  def self.goodbye_message
    "Goodbye! Event Reporter is shutting down.\n\n"
  end

  def self.empty_queue_error_message
    "Print was unsuccessful because the queue was empty. Try running 'load' followed by a 'find' command first."
  end

  def self.successful_print_message(count)
    "Successfully printed #{count} queue items."
  end

  def self.successful_print_by_message(count, param)
    "Successfully printed #{count} queue items by #{param}."
  end

  def self.count_message(current)
    "The queue currently has #{current} items in it."
  end

  def self.successful_clear_message
    "The queue was successfully cleared."
  end

end
