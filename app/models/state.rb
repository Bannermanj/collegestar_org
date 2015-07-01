class State

  @@states = {
    "AL" => "Alabama",
    "AK" => "Alaska",
    "AZ" => "Arizona",         
    "AR" => "Arkansas",        
    "CA" => "California",      
    "CO" => "Colorado",
    "CT" => "Connecticut",    
    "DE" => "Delaware",
    "FL" => "Florida",      
    "GA" => "Georgia",
    "HI" => "Hawaii", 
    "ID" => "Idaho",
    "IL" => "Illinois",
    "IN" => "Indiana",
    "IA" => "Iowa",
    "KS" => "Kansas",
    "KY" => "Kentucky",
    "LA" => "Louisiana",
    "ME" => "Maine",
    "MD" => "Maryland",
    "MA" => "Massachusetts",
    "MI" => "Michigan",
    "MN" => "Minnesota",
    "MS" => "Mississippi",
    "MO" => "Missouri",
    "MT" => "Montana",
    "NE" => "Nebraska",
    "NV" => "Nevada",
    "NH" => "New Hampshire",
    "NJ" => "New Jersey",
    "NM" => "New Mexico",
    "NY" => "New York",
    "NC" => "North Carolina",
    "ND" => "North Dakota",
    "OH" => "Ohio",
    "OK" => "Oklahoma",
    "OR" => "Oregon",
    "PA" => "Pennsylvania",
    "RI" => "Rhode Island",
    "SC" => "South Carolina",
    "SD" => "South Dakota",
    "TN" => "Tennessee",
    "TX" => "Texas",
    "UT" => "Utah",
    "VT" => "Vermont",
    "VA" => "Virginia", 
    "WA" => "Washington",
    "WV" => "West Virginia",
    "WI" => "Wisconsin",
    "WY" => "Wyoming"
    }

  def self.all
    @@states 
  end

  def self.get_abbreviation(name)
    @@states.each do |abbrev, state_name|
      return abbrev if state_name.downcase == name.downcase
    end
    false
  end

  def self.get_name(abbreviation)
    @@states.each do |abbrev, state_name|
      return state_name if abbrev.downcase == abbreviation.downcase
    end
    false
  end
end