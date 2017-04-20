require 'colorize'

class CommandLineInterface
  def self.welcome
    puts ".-----------------------------------------.".red
    puts "|-------  Get Your Representatives -------|"
    puts "|-------        Information!       -------|"
  end

  def self.get_address_from_user
    puts "===========================================".blue
    puts "|~~      Please Enter: City, State      ~~|"
    puts "|~~~~        (Ex: Boston, MA)        ~~~~~|"
    puts "._________________________________________.".red

    address = gets.chomp
    puts ""

    until address != nil
      puts "Sorry, that's not valid try again"
      address = gets.chomp
    end

    address
  end

  def self.list_officials(api_hash, address)
    puts "----------------------------------------------------------------------------".blue
    puts "----------------------------------------------------------------------------".red
    puts "--------            Please Select an Official From List   ------------------"
    puts "----------------------------------------------------------------------------".red
    Office.get_offices(api_hash)
    official_hash = Official.get_officials(api_hash,address)
    puts ""
    # The user is going to put a number
    puts ""
    choice = gets.chomp


  end

  def self.find_previous_states_searched
    State.pluck(:abbreviation)
  end

  def self.find_previous_officials_searched
    Official.pluck(:name)
  end

end
