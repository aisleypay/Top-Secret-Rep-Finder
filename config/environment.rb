require 'bundler'
Bundler.require
require 'require_all'
require 'colorize'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = nil
require_all 'app'
require_all 'lib'
require 'terminal-table'
