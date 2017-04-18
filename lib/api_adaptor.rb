require'json'
require 'pry'
require 'httparty'

require_relative './command_line_interface'

def parse_address(address)
  address_url = address.split(", ").collect {|el| "#{el}%20" }.join
end

def get_info_from_api(address)
  api_key = 'AIzaSyCudI68KuGNt9uF_SzvqocmCnBVo-uZkYs'

  response = HTTParty.get("https://www.googleapis.com/civicinfo/v2/representatives?key=#{api_key}&address=#{address}", query: {'api_key_id' => api_key }, format: :plain)
  info = JSON.parse(response)
  info
end

def all_state_officials_names(info)
  info["officials"].collect{|official| official["name"] }
end

def get_senators(info)
  indicies = info["offices"].select { |office | office["name"] == "United States Senate" }[0]["officialIndices"]

  senators = all_state_officials_names(info).select.with_index { |name, idx| (idx == indicies[0]) || (idx == indicies[1]) }

  puts "Here are your senators: 1. #{senators[0]}, 2. #{senators[1]}"
  puts "Which Senator would you like to know more about? Please pick a number."
  choice = gets.chomp
end

def show_representative_info(address)
  new_address = parse_address(address)
  info =  get_info_from_api(new_address)
  get_senators(info)
end
