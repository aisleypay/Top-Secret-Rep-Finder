class Senator < ActiveRecord::Base
  belongs_to :state
  belongs_to :political_party



end
