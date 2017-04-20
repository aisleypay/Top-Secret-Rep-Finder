class Office < ActiveRecord::Base
  has_many :office_officials
  has_many :officials, through: :office_officials

  def self.governors
    Office.where(position: "Governor").first.officials.count
  end

  private

  def self.all_office_titles(api_hash)
    api_hash["offices"].collect{|office| office["name"] }
  end

  def self.get_office_api_hash(title, api_hash)
    office_hash = api_hash["offices"].select{|off| off["name"] == title}[0]
  end

  def self.get_offices(api_hash)
    titles = all_office_titles(api_hash)
    office_hash = []

    titles.each do |title|
      new_office = get_office_api_hash(title, api_hash)
      office_hash << { position: new_office["name"], level: new_office["levels"].to_s}
    end

    office_hash.each { |office| Office.find_or_create_by(office) }
  end

  def self.get_indicies_of_offices(api_hash)
    api_hash["offices"].collect { |office| office["officialIndices"] }
  end

  def self.get_specific_office_title (official_index, api_hash)
    indicies = get_indicies_of_offices(api_hash)
    position_index = nil

    indicies.each_with_index { |el, idx | position_index = idx if el.include?(official_index) }
    position_index
  end

  def self.get_official_id(official_index, api_hash)
    office_title =  all_office_titles(api_hash)[get_specific_office_title(official_index, api_hash)]

    office_id = Office.find_by(position: office_title).id
  end
end
