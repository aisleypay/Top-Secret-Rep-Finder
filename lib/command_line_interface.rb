require 'terminal-table'
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
  end

  def self.list_officials(api_hash, address)

    puts "----------------------------------------------------------------------------".blue
    puts "----------------------------------------------------------------------------".red
    puts "--------            Please Select an Official From List   ------------------"
    puts "----------------------------------------------------------------------------".red

    Office.get_offices(api_hash)
    official_hash = Official.get_officials(api_hash,address)
    # The user is going to put a number
    choice = gets.chomp.to_i - 1
  end

  def self.user_choices(choice)

    until choice == 4
      puts "Would you like to:"
      puts "1. Find out about another representative?"
      puts "2. Choose another location?"
      puts "3. Here are some interesting facts!"
      puts "4. Exit?"

      choice = gets.chomp.to_i

      case choice
        when 1
          choice = ApiAdaptor.show_representative_info(address)
          official_info = Official.display_official_info(choice)
          puts official_info
          puts ""

        when 2
          address = CommandLineInterface.get_address_from_user
          choice = ApiAdaptor.show_representative_information(address)
          official_info = Official.display_official_info(choice)
          puts official_info + "\n\n"

        when 3
          puts "Did you know?\n\n"
          fun_methods = [Official.top_5_states_officials_count, Official.party_tally, Office.governors, OfficeOfficial.top_5_offices]
          fun_methods.sample
        when 4
          puts "Good Bye"
        else
          puts "MAKE A CHOICE FOOL wtf..."
      end

    end
  end

end
