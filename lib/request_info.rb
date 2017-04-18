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
  binding.pry
  info = JSON.parse(response)
  puts info

end

def show_representative_info(address)
  new_address = parse_address(address)
  get_info_from_api(new_address)
end
