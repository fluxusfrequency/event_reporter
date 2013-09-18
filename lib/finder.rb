class Finder
  def initialize
    @queuer = Queuer.new
  end

  def find_parse
    if @parts[1] == nil
        puts "\nPlease enter a column and optional criteria to find by. Type 'help find' for help."
    else
      if @find_criteria
        find_by_criteria(@parts[1].to_sym, @parts[2..-1].join(" ").to_s)
        puts "\nSuccessfully found all of the #{@parts[1].to_sym}s matching #{@parts[2..-1].join(" ").to_s}."
      else
        find_by_column(@parts[1].to_sym)
        "\nSuccessfully found all of the #{@parts[1].to_sym}s."
      end
  end

  def find_by_column(column)
    if column.nil?
     puts "Couldn't find any data matching the type #{column}."
     return
    end
    @queuer.add_to_queue(column)
  end

  def find_by_criteria(column, criteria)
    if contents.nil? || criteria.nil?
     puts "Couldn't find any data matching the type #{column} or the criteria #{criteria}."
     return
    end
    @queuer.add_to_queue_with_criteria(column, criteria)
  end
end
