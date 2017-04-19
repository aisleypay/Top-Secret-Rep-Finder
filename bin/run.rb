#!/usr/bin/env ruby

require_relative '../config/environment'

welcome

address = get_address_from_user

choice = show_representative_info(address)

until choice == 3
  official_info = Official.display_official_info(choice)
  puts official_info

  puts "Would you like to "
end
