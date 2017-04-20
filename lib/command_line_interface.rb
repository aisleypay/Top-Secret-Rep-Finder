class CommandLineInterface
  def self.welcome
    puts "Get your Representatives information here!"
  end

  def self.get_address_from_user
    puts "Which state would you like to get information about?"

    address = gets.chomp
    puts ""

    until address != nil
      puts "Sorry, that's not valid try again"
      address = gets.chomp
    end

    address
  end

  def self.list_officials(api_hash, address)
    puts "Here are your officials:"
    puts ""
    Office.get_offices(api_hash)
    Official.get_officials(api_hash,address)
    puts ""

    puts "Which Official would you like to know more about?"
    puts ""
    choice = gets.chomp
  end

  def self.find_previous_states_searched
    State.pluck(:abbreviation)
  end

  def self.find_previous_officials_searched
    Official.pluck(:name)
  end

end
