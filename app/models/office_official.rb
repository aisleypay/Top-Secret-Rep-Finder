# Join table/class for offices and officials
class OfficeOfficial < ActiveRecord::Base
  belongs_to :official
  belongs_to :office

  def self.top_5_offices
    rows = self.joins(:office, :official).group('offices.position').order('officials.name').count.sort_by{ |k, v| v}[-5..-1]
    table = Terminal::Table.new :headings => ['Position', 'Position Count'], :rows => rows

    puts "*There are more Sheriff's than any other Official position in the USA*\n\n"
    puts table
  end
end
