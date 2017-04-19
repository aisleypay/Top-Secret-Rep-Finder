class Official < ActiveRecord::Base
  belongs_to :state

  def self.display_official_info(choice)
    chosen_official = self.find_by(name: choice)

    self.get_columns_without_id.map do |attribute|
      puts "#{attribute.capitalize}: #{chosen_official[attribute]}" unless attribute == "state_id"
    end

  end

  private

  def self.get_columns_without_id
    self.columns[1..-1].collect{ |c| c.name}
  end

end
