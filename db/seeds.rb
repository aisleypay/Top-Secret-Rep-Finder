def seed_cities_and_states
  list = CsvParser.get_cities_states

  list.each do |state|
    State.find_or_create_by(abbreviation: state[1])
  end

  list.each do |city|
    City.find_or_create_by(city: city[0], state_id: State.find_by(abbreviation: city[1]).id)
  end
end

def seed_officials
  locations = CsvParser.get_cities_states.collect {|location| location.join(", ") }

  us_territories = %w(PR VI AA FM MH PW AE AP AS GU)

  locations.uniq.each do |location|
    begin
      next if us_territories.include?(location.split(", ")[1])

      new_address = ApiAdaptor.parse_address(location)
      api_hash =  ApiAdaptor.get_info_from_api(new_address)

      Office.get_offices(api_hash)
      Official.get_officials(api_hash,location.split(", "))
    rescue
      next
    end
  end

end

# seed_cities_and_states
seed_officials
