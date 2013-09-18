require_relative './loader.rb'

class Finder
  def initialize
    @loader = Loader.new
  end

  def find_parse
    if @extension
      if @find_criteria
        find_by_criteria(@extension.to_sym, @find_criteria.join(" ").to_s)
        puts "\nSuccessfully found all of the #{@extension.to_sym}s matching #{@find_criteria.join(" ").to_s}."
      else
        find_by_column(@extension.to_sym)
        "\nSuccessfully found all of the #{@extension.to_sym}s."
      end
    else
      puts "\nPlease enter a column and optional criteria to find by. Type 'help find' for help."
    end
  end

  def find_by_column(column)
    #if column.nil?
    #  puts "Couldn't find any data matching the type #{column}."
    #  return
    #end
    add_to_queue(column)
  end

  def find_by_criteria(column, criteria)
    #if @contents.nil?
    #  puts "Couldn't find any data matching the type #{column} or the criteria #{criteria}."
    #  return
    #end
    add_to_queue_with_criteria(column, criteria)
  end
end
