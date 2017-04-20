class CsvParser

  def self.parse_csv
    zip_file = CSV.read("lib/uszipsv1.1.csv", :encoding => 'windows-1251:utf-8')
    zip_file.shift
    zip_file
  end

  def self.get_cities_states
    zip_file = self.parse_csv
    zip_file.collect do |zip_code|
      zip_code.values_at(3, 4) #city and state
    end

  end
end
