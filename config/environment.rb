require 'bundler'
Bundler.require

require_relative '../lib/command_line_interface.rb'
require_relative '../lib/request_info.rb'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')

welcome
address = get_address_from_user
show_representative_info(address)
