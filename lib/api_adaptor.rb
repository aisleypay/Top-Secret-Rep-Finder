require'json'
require 'pry'
require 'httparty'

require_relative './command_line_interface'

#api adaptor
def create_state(address)
  State.find_or_create_by(abbreviation: address)
end

#api adaptor
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

  titles.each do |title|
    new_office = get_office_api_hash(title, info)

    office_hash << { position: new_office["name"], level: new_office["levels"].to_s}
  end
  office_hash.each { |office| Office.find_or_create_by(office) }

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

def create_off_sen(official_index, office_id)
  OfficeOfficial.find_or_create_by(official_id: official_index, office_id: office_id)
end

def all_state_officials_names(info)
  info["officials"].collect{|official| official["name"] }
end

def get_indicies_of_offices(info)
  info["offices"].collect { |office| office["officialIndices"] }
end

def get_officials(info, address)
  indicies = get_indicies_of_offices(info)
  officials = all_state_officials_names(info)
  officials_hash = get_official_hash(officials, info, address)

  officials_hash.each do |official_hash|
    new_official = Official.find_or_create_by(official_hash)
    index_of_official = (all_state_officials_names(info)).index(official_hash[:name])
    office_id = get_official_position_title(index_of_official, info)
    create_off_sen(new_official.id, office_id)

    puts "#{Office.find_by(id: office_id).position} : #{official_hash[:name]}"
  end
end

def get_official_hash(officials, info, address)
  official_hashes = []

  officials.each do |official|

    next if (official == "Donald J. Trump" || official == "Mike Pence")
    new_official = get_official_api_hash(official, info)
    official_hashes << {
      name: official,
      address: parse_official_address(new_official),
      party: get_party(new_official),
      phones: get_phone_number(new_official),
      urls: get_url(new_official),
      photoUrl: get_photo_url(new_official),
      Facebook: get_facebook(new_official),
      Twitter: get_twitter(new_official),
      YouTube: get_youtube(new_official),
      state_id: State.find_by(abbreviation: address).id,
    }
  end

  official_hashes
end

def get_official_api_hash (official, info)
  official_hash = info["officials"].select{|off| off["name"] == official }[0]
  official_hash
end

#parsing
def parse_official_address(official_hash)
  official_hash["address"][0].collect {|add, val| val }.join(" ")
end

#parsing
def get_party(official_hash)
  official_hash["party"].nil? ? "N/A" : official_hash["party"]
end

#parsing
def get_phone_number(official_hash)
  official_hash["phones"][0].nil? ? "N/A" : official_hash["phones"][0]
end

#parsing
def get_url(official_hash)
  official_hash["urls"].nil? ? "N/A" : official_hash["urls"][0]
end

#parsing
def get_photo_url(official_hash)
  official_hash["photoUrl"].nil? ? "N/A" : official_hash["photoUrl"]
end

#parsing
def get_twitter(official_hash)
  official_hash["channels"].nil? ? "N/A" : official_hash["channels"].map { |social| social["id"] if social["type"] == "Twitter" }.compact.join
end

#parsing
def get_facebook(official_hash)
  official_hash["channels"].nil? ? "N/A" : official_hash["channels"].map { |social| social["id"] if social["type"] == "Facebook" }.compact.join
end

#parsing
def get_youtube(official_hash)
  official_hash["channels"].nil? ? "N/A" : official_hash["channels"].map { |social| social["id"] if social["type"] == "YouTube" }.compact.join
end


def show_representative_info(address)
  new_address = parse_address(address)
  info =  get_info_from_api(new_address)

  choice = CommandLineInterface.list_officials(info, address)
end
