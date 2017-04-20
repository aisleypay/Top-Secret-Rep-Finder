class City < ActiveRecord::Base
belongs_to :state
has_many :officials, through: :state


  def find_officials
    self.officials
  end

end
