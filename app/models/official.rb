class Senate < ActiveRecord::Base


  def all_state_officials_names
    info["officials"].collect{|official| official["name"] }
  end

  def get_senators
    indicies = info["offices"].select { |office | office["name"] == "United States Senate" }[0]["officialIndices"]
    binding.pry

    all_state_officials_names.select { |name, idx| (idx == indicies[0]) || (idx == indicies[1]) }
  end

end
