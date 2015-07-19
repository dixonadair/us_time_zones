class USTZones
	def self.getZone(lat, lng)
		if lat.class != String
			lat = lat.to_s
		end
		if lng.class != String
			lng = lng.to_s
		end
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

# 53.37734988622845, -169.504588281682
class TZtest
	def self.test(lat, lng)
		if HAWAII_ALEUTIAN.include?([lat,lng])
			p "includes bla bla!"
		else
			p "does not include bla bla bla!"
		end
	end
end

# Version with determining if it's in the US first using Google Maps API (I don't want to have to rely on the GMaps API call, though, because there are limits to how much you can call it and you have to pay for it beyond that limit)
class TZ
	def self.whichTZ?(point)
		alaska = GeoRuby::SimpleFeatures::Polygon.from_coordinates([ALASKA])
		hawaii_aleutian_1 = GeoRuby::SimpleFeatures::Polygon.from_coordinates([HAWAII_ALEUTIAN_1])
		hawaii_aleutian_2 = GeoRuby::SimpleFeatures::Polygon.from_coordinates([HAWAII_ALEUTIAN_2])
		central = GeoRuby::SimpleFeatures::Polygon.from_coordinates([CENTRAL])
		eastern = GeoRuby::SimpleFeatures::Polygon.from_coordinates([EASTERN])
		pacific = GeoRuby::SimpleFeatures::Polygon.from_coordinates([PACIFIC])
		mountain = GeoRuby::SimpleFeatures::Polygon.from_coordinates([MOUNTAIN])

		pointObject = GeoRuby::SimpleFeatures::Point.from_x_y(point[0], point[1])
		url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=#{point[0].to_s},#{point[1].to_s}&key=AIzaSyBgUT0t3K3y9cKJgITa8X1O7uGYjguNZT4"
		response = HTTParty.get(url).to_json
		response = JSON.parse(response)

		if response["results"] == []
			return "Error"
		elsif response["results"][0]["formatted_address"].include?("USA")
			if eastern.contains_point?(pointObject)
				return "US Eastern Time Zone"
			elsif central.contains_point?(pointObject)
				return "US Central Time Zone"
			elsif pacific.contains_point?(pointObject)
				return "US Pacific Time Zone"
			elsif mountain.contains_point?(pointObject)
				return "US Mountain Time Zone"
			elsif hawaii_aleutian_1.contains_point?(pointObject) || hawaii_aleutian_2.contains_point?(pointObject)
				return "US Hawaii-Aleutian Time Zone"
			elsif alaska.contains_point?(pointObject)
				return "US Alaska Time Zone"
			end	
		else
			return "Unable to determine time zone for coordinates outside the US"
		end
	end
end