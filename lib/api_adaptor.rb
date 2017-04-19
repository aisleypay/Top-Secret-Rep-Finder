require'json'
require 'pry'
require 'httparty'

require_relative './command_line_interface'

class ApiAdaptor
  def self.create_state(address)
    State.find_or_create_by(abbreviation: address)
  end

  def self.parse_address(address)
    create_state(address)
    address_url = address.split(", ").collect {|el| "#{el}%20" }.join
  end

  def self.get_info_from_api(address)
    api_key = 'AIzaSyCudI68KuGNt9uF_SzvqocmCnBVo-uZkYs'

    response = HTTParty.get("https://www.googleapis.com/civicinfo/v2/representatives?key=#{api_key}&address=#{address}", query: {'api_key_id' => api_key }, format: :plain)

    api_hash = JSON.parse(response)
  end

  #Parse Data from api_hash

  def self.parse_official_address(official_hash)
    official_hash["address"][0].collect {|add, val| val }.join(" ")
  end

  def self.get_party(official_hash)
    official_hash["party"].nil? ? "N/A" : official_hash["party"]
  end

  def self.get_phone_number(official_hash)
    official_hash["phones"].nil? ? "N/A" : official_hash["phones"][0]
  end

  def self.get_url(official_hash)
    official_hash["urls"].nil? ? "N/A" : official_hash["urls"][0]
  end

  def self.get_photo_url(official_hash)
    official_hash["photoUrl"].nil? ? "N/A" : official_hash["photoUrl"]
  end

  def self.get_twitter(official_hash)
    official_hash["channels"].nil? ? "N/A" : official_hash["channels"].map { |social| social["id"] if social["type"] == "Twitter" }.compact.join
  end

  def self.get_facebook(official_hash)
    official_hash["channels"].nil? ? "N/A" : official_hash["channels"].map { |social| social["id"] if social["type"] == "Facebook" }.compact.join
  end

  def self.get_youtube(official_hash)
    official_hash["channels"].nil? ? "N/A" : official_hash["channels"].map { |social| social["id"] if social["type"] == "YouTube" }.compact.join
  end

  def self.show_representative_information(address)
    new_address = parse_address(address)
    api_hash =  get_info_from_api(new_address)

    choice = CommandLineInterface.list_officials(api_hash, address)
  end

end
