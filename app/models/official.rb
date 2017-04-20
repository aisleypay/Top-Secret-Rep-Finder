class Official < ActiveRecord::Base
  belongs_to :state
  has_many :office_officials
  has_many :offices, through: :office_officials


  def self.display_official_info(choice, address)
    officials_hash = self.get_officials(ApiAdaptor.get_info_from_api(address), address)
    name_choice = officials_hash[choice][:name]

    chosen_official = self.find_by(name: name_choice)

    self.get_columns_without_id.each do |attribute|
      puts "\n----------------------------------------------------------------------------".blue
      puts "#{attribute.capitalize}: #{chosen_official[attribute]}" unless attribute == "state_id"
    end
  end

  def self.party_tally
    rows = Official.group(:party).size.to_a
    table = Terminal::Table.new :headings => ["Party(?)", "Number of Officials in Party"], :rows => rows

    puts "How about, did you know that most databases need to be cleaned?"
    puts table
  end

  def self.top_5_states_officials_count
    rows = State.joins(:officials).group(:abbreviation).order(:abbreviation).count.sort_by{ |k, v| v}[-5..-1]
    table = Terminal::Table.new :headings => ["State", "Official Count"], :rows => rows

    puts "That TEXAS has mad officials?\n\n"
    puts table
  end

###################################################################################
  private

  def self.get_columns_without_id
    self.columns[1..-1].collect{ |c| c.name}
  end

  def self.all_state_officials_names(api_hash)
    api_hash["officials"].collect{|official| official["name"] }
  end

  def self.get_officials(api_hash, address)

    indicies = Office.get_indicies_of_offices(api_hash)
    officials = all_state_officials_names(api_hash)
    officials_hash = get_official_hash(officials, api_hash, address)

    officials_hash.each.with_index(1) do |official_hash, i|
      new_official = Official.find_or_create_by(official_hash)
      index_of_official = (all_state_officials_names(api_hash)).index(official_hash[:name])
      office_id = Office.get_official_id(index_of_official, api_hash)

      OfficeOfficial.find_or_create_by(official_id: new_official.id, office_id: office_id)

      puts "----------------------------------------------------------------------------".blue
      puts "#{i}.)   #{official_hash[:name]} (#{Office.find_by(id: office_id).position})"
    end

    officials_hash
  end

  def self.get_official_api_hash (official, api_hash)
    official_hash = api_hash["officials"].select{|off| off["name"] == official }[0]
    official_hash
  end

  def self.get_official_hash(officials, api_hash, address)
    official_hashes = []

    officials.each do |official|
      next if (official == "Donald J. Trump" || official == "Mike Pence")
      new_official = get_official_api_hash(official, api_hash)

      official_hashes << {
        name: official,
        address: ApiAdaptor.parse_official_address(new_official),
        party: ApiAdaptor.get_party(new_official),
        phones: ApiAdaptor.get_phone_number(new_official),
        urls: ApiAdaptor.get_url(new_official),
        photoUrl: ApiAdaptor.get_photo_url(new_official),
        Facebook: ApiAdaptor.get_facebook(new_official),
        Twitter: ApiAdaptor.get_twitter(new_official),
        YouTube: ApiAdaptor.get_youtube(new_official),
        state_id: State.find_by(abbreviation: ApiAdaptor.separate_city_state(address)[1]).id
                                                                        # add [0] before [1] when seeding
       }
    end

    official_hashes
  end

end
