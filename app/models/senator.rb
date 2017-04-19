class Senator < ActiveRecord::Base
  belongs_to :state

  def self.display_senator_info(choice)
    chosen_senator = self.find_by(name: choice)

    self.get_columns_without_id.map do |x|
      puts "#{x.capitalize}: #{chosen_senator[x]}" unless x == "state_id"
    end



  end


  private

  def self.get_columns_without_id
    Senator.columns[1..-1].collect{ |c| c.name}
  end

end
