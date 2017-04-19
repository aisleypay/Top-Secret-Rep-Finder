class OfficeSenator < ActiveRecord::Base
  has_many :senators
  has_many :offices

end
