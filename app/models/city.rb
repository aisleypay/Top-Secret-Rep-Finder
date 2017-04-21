# City class instantiates each city.
class City < ActiveRecord::Base
belongs_to :state
has_many :officials, through: :state

end
