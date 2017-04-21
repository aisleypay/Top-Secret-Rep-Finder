#!/usr/bin/env ruby

require_relative '../config/environment'
require 'terminal-table'

CommandLineInterface.welcome
address = CommandLineInterface.get_address_from_user
choice = ApiAdaptor.show_representative_information(address)
Official.display_official_info(choice, address)
CommandLineInterface.user_choices(choice, address)
