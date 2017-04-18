require 'bundler'
Bundler.require

# require_relative '../lib/command_line_interface.rb'
# require_relative '../lib/request_info.rb'
require_all 'app'
require_all 'lib'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
