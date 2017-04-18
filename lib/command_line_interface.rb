def welcome
  "Get your Representatives information here!"
end

def get_address_from_user
  puts "Which location would you like to get information about?"
  puts "Kindly write the address is the following format: Street#, Street Name, City, State. Include what information you can, we will figure out the rest!"

  address = gets.chomp

  # until subject_array.include?(subject)
  #   puts "Sorry, that's not valid try again"
  #   subject = gets.chomp.downcase
  # end

  address
end

def specific_subject
  puts "What would you specifically liek to know about #{get_address_from_user}?"
  subject_specfic = gets.chomp.downcase
end
