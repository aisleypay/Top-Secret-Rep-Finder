class OfficeOfficial < ActiveRecord::Base
  has_many :officials
  has_many :offices

end
