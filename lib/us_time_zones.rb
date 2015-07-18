require "us_time_zones/version"

require "json"
require "httparty"

class USTZones
	def self.getZone(lat, lng)
		url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=#{lat},#{lng}&key=AIzaSyBgUT0t3K3y9cKJgITa8X1O7uGYjguNZT4"
		response = HTTParty.get(url).to_json
		response = JSON.parse(response)

		if response["results"] == []
			p "Error"
		elsif response["results"][0]["formatted_address"].include?("USA")
			p "You're in the USA"
		else
			p "You're not in the USA"
		end
	end
end