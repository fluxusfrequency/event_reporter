class Queuer
  def initialize
    @queue = []
  end

  def queue_parse
    case @extension
      when "count"
       puts "\nThe queue currently has #{queue_count} items in it."
      when "clear"
        queue_clear
        puts "\n The queue was cleared."
      when "print"
        if @subcommand == "by"
          queue_print_by_mcguffin
        else
          queue_print
        end
      else command_error
    end
  end

  def queue_count
    @queue.length
  end

  def queue_clear
    @queue = []
  end

  def queue_print
    @queue.each do |item|
      puts "#{item}"
    end
    puts @queue
    puts "\nSuccessfully printed queue."
    return "successfully printed queue"
  end

  def queue_print_by_mcguffin
    #@queue.sort!
    @queue.each do |item|
      puts "#{item}"
    end
    puts "\nSuccessfully printed queue by last name."
    return "successfully printed by last name"
  end

  def add_to_queue(column)
    queue_clear
    @contents.each do |row|
      field_name = column.to_sym
      matching_field = row[field_name].downcase
      @queue << row
    end
  end

  def add_to_queue_with_criteria(column, criteria)
    queue_clear
    @contents.each do |row|
      # What is the data in the column we are looking for?
      field_name = column.to_sym
      matching_field = row[field_name].downcase

      # if the column with the name that matches the type specified
      # equals the criteria that I am looking for
      if matching_field == criteria.downcase
      # then add this attendees data to the queue
      @queue << row
      #@queue.push Attendee.new(row)
      end
    end
  end
end
