class Office < ActiveRecord::Base
  has_many :senators, through: :office_senators

end
