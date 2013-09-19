class Printer
  # def initialize
  # end

  def print(queue)
    create_tabs
    queue.each do |item|
      puts "#{item}"
    end
    if queue.length == 0
      puts "\n\t\tPrint was unsuccessful because the queue was empty. Try running a 'find' command first."
      return ''
    else
      puts "\n\t\tSuccessfully printed #{queue.length} queue items."
      return "successfully printed #{queue.length} queue items"
    end
  end

  def print_by(queue, param)
    create_tabs
    queue = queue.sort_by {|attendee| attendee[param.downcase.to_sym]}
    queue.each do |item|
      puts "#{item}"
    end
    if queue.length == 0
      puts "\n\t\tPrint was unsuccessful because the queue was empty. Try running a 'find' command first."
      return ''
    else
      puts "\n\t\tSuccessfully printed #{queue.length} queue items by #{param}."
      return "successfully printed #{queue.length} queue items by #{param}"
    end
  end

  def create_tabs
    puts "----------------------------------------------------------------------------------------------------------------------------------------------"
    puts "LAST NAME       FIRST NAME  EMAIL                ZIPCODE     CITY                    STATE  ADDRESS                              PHONE"
    puts "----------------------------------------------------------------------------------------------------------------------------------------------"
  end

end
