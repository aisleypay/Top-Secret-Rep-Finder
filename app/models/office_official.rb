class OfficeOfficial < ActiveRecord::Base
  belongs_to :official
  belongs_to :office

  def self.top_5_offices
    self.joins(:office, :official).group('offices.position').order('officials.name').count.sort_by{ |k, v| v}[-5..-1]
  end

end
