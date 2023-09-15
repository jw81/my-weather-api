namespace :observations do
  desc 'Retrieve current observations for each location'
  task get: :environment do
    app_id = Rails.application.credentials.dig(:openweathermap, :appid)

    Location.all.each do |location|
      lat = location.latitude
      lon = location.longitude

      puts "Retrieving observation for #{location.name}..."
      response = HTTParty.get("https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{lon}&units=imperial&appid=#{app_id}&exclude=minutely")
    
      current_temperature = response['current']['temp']
      description = response['current']['weather'].first['description']

      location.observations.create!(
        current_temperature: current_temperature,
        description: description
      )

      puts "Observation recorded for #{location.name}!!!"
    end
  end
end
