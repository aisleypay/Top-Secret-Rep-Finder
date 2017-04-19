require'json'
require 'pry'
require 'httparty'

require_relative './command_line_interface'

def create_state(address)
  State.create("abbreviation" => address)
end

def parse_address(address)
  create_state(address)
  address_url = address.split(", ").collect {|el| "#{el}%20" }.join
end

def get_info_from_api(address)
  api_key = 'AIzaSyCudI68KuGNt9uF_SzvqocmCnBVo-uZkYs'

  response = HTTParty.get("https://www.googleapis.com/civicinfo/v2/representatives?key=#{api_key}&address=#{address}", query: {'api_key_id' => api_key }, format: :plain)

  info = JSON.parse(response)
end

def all_office_titles(info)
  info["offices"].collect{|office| office["name"] }
end

def get_office_api_hash(title, info)
  office_hash = info["offices"].select{|off| off["name"] == title}[0]
end

def get_offices(info)
  titles = all_office_titles(info)
  office_hash = []

  titles.each { |title|
    new_office = get_office_api_hash(title, info)

    office_hash << { position: new_office["name"], level: new_office["levels"] }
  }

  office_hash.each { |office| Office.create(office) }
end

def get_indicies_of_offices(info)
  info["offices"].collect { |office| office["officialIndices"] }
end

def get_specific_office_title (official_index, info)
  indicies = get_indicies_of_offices(info)
  position_index = nil

  indicies.each_with_index { |el, idx | position_index = idx if el.include?(official_index) }
  position_index
end

def get_official_position_title(official_index, info)
  office_title =  all_office_titles(info)[get_specific_office_title(official_index, info)]

  office_id = Office.find_by(position: office_title).id
end

def create_off_sen(senator_index, office_id)
  OfficeSenator.create(senator_id: senator_index, office_id: office_id)
end

def all_state_officials_names(info)
  info["officials"].collect{|official| official["name"] }
end

def get_senators(info, address)
  indicies = info["offices"].select { |office | office["name"] == "United States Senate" }[0]["officialIndices"]
  get_offices(info)
  #senators names
  senators = all_state_officials_names(info).select.with_index { |name, idx| indicies.include?(idx) }
  senator_hashes = get_senator_hash(senators, info, address)

  senator_hashes.each do |senator_hash|
    new_senator = Senator.create(senator_hash)
    index_of_senator = (all_state_officials_names(info)).index(senator_hash[:name])
    office_id = get_official_position_title(index_of_senator, info)

    create_off_sen(new_senator.id, office_id)
  end

  puts "Here are your senators: #{senators[0]} and #{senators[1]}"
  puts "Which Senator would you like to know more about?"
  #choice is string of senator name
  choice = gets.chomp
end

def get_senator_hash(senators, info, address)
  senator_hashes = []

  senators.each do |senator|
    new_senator = get_senator_api_hash(senator, info)
    senator_hashes << {
      name: senator,
      address: parse_official_address(new_senator),
      party: get_party(new_senator),
      phones: get_phone_number(new_senator),
      urls: get_url(new_senator),
      photoUrl: get_photo_url(new_senator),
      Facebook: get_facebook(new_senator),
      Twitter: get_twitter(new_senator),
      YouTube: get_youtube(new_senator),
      state_id: State.find_by(abbreviation: address).id,
    }
  end

  senator_hashes
end

def get_senator_api_hash (senator, info)
  senator_hash = info["officials"].select{|off| off["name"] == senator }[0]
  senator_hash
end

def parse_official_address(senator_hash)
  senator_hash["address"][0].collect {|add, val| val }.join(" ")
end

def get_party(senator_hash)
  senator_hash["party"]
end

def get_phone_number(senator_hash)
  senator_hash["phones"][0]
end

def get_url(senator_hash)
  senator_hash["urls"][0]
end

def get_photo_url(senator_hash)
  senator_hash["photoUrl"]
end

def get_twitter(senator_hash)
  senator_hash["channels"].map { |social| social["id"] if social["type"] == "Twitter" }.compact.join
end

def get_facebook(senator_hash)
  senator_hash["channels"].map { |social| social["id"] if social["type"] == "Facebook" }.compact.join
end

def get_youtube(senator_hash)
  senator_hash["channels"].map { |social| social["id"] if social["type"] == "YouTube" }.compact.join
end


def show_representative_info(address)
  new_address = parse_address(address)
  info =  get_info_from_api(new_address)
  choice = get_senators(info, address)
  senator_hash = get_senator_api_hash(choice, info)
end