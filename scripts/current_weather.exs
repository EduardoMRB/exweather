[id | _rest] = System.argv
temp = CurrentWeather.weather(id)

IO.puts "The current weather for #{id} is #{temp} fahrenheit."
