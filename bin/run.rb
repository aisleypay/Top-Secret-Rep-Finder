#!/usr/bin/env ruby

require_relative '../config/environment'

welcome
address = get_address_from_user
choice = show_representative_info(address)
senator_info = Senator.display_senator_info(choice)
puts senator_info
