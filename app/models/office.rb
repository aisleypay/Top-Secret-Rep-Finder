class Office < ActiveRecord::Base
  has_many :officials, through: :office_officials

end
