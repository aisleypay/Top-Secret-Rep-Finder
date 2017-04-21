# instantiates and stores in SQLite database each state
class State < ActiveRecord::Base
  has_many :officials
  has_many :cities
  has_many :offices, through: :office_officials
end
