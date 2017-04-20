class CommandLineInterface
  def self.welcome
    puts "Get your Representatives information here!"
  end

  def self.get_address_from_user
    puts "Which location would you like to get information about? Please input as 'city, state'"

    address = gets.chomp
    puts ""

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

  def self.user_choices(choice)

    until choice == 4
      puts "Would you like to:"
      puts "1. Find out about another representative?"
      puts "2. Choose another location?"
      puts "3. Here are some interesting facts!"
      puts "4. Exit?"

      choice = gets.chomp.to_i

      case choice
        when 1
          choice = ApiAdaptor.show_representative_info(address)
          official_info = Official.display_official_info(choice)
          puts official_info
          puts ""

        when 2
          address = CommandLineInterface.get_address_from_user
          choice = ApiAdaptor.show_representative_information(address)
          official_info = Official.display_official_info(choice)
          puts official_info
          puts ""

        when 3
          puts "Did you know?"
          puts ""
          fun_methods = [Official.top_5_states_officials_count, Official.party_tally, Office.governors, OfficeOfficial.top_5_offices]
          
        when 4
          puts "Good Bye"
        else
          puts "MAKE A CHOICE FOOL wtf..."
      end

    end
  end

end
