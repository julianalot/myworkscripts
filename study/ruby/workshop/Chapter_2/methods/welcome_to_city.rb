def welcome_to_city city
    return city if city == "Garbage"
    "Welcome to " + city
end
puts welcome_to_city "Garbage"
puts welcome_to_city "New York"
