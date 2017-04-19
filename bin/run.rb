#!/usr/bin/env ruby

require_relative '../config/environment'

CommandLineInterface.welcome

address = CommandLineInterface.get_address_from_user
choice = show_representative_info(address)
official_info = Official.display_official_info(choice)
puts official_info

until choice == 5
  puts "Would you like to:"
  puts "1. Find out about another representative?"
  puts "2. Choose another state?"
  puts "3. View Previously Searched States"
  puts "4. View Previously Viewed Officials"
  puts "5. Exit?"

  choice = gets.chomp.to_i

  case choice
    when 1
      choice = show_representative_info(address)
      official_info = Official.display_official_info(choice)
      puts official_info

    when 2
      address = CommandLineInterface.get_address_from_user
      choice = show_representative_info(address)
      official_info = Official.display_official_info(choice)
      puts official_info

    when 3
      puts CommandLineInterface.find_previous_states_searched

    when 4
      puts CommandLineInterface.find_previous_officials_searched

    when 5
      puts "Good Bye"
  end

end
