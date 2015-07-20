require "us_time_zones/version"

require_relative "us_time_zones/tz_coord_files/hawaii_aleutian_1"
require_relative "us_time_zones/tz_coord_files/hawaii_aleutian_2"
require_relative "us_time_zones/tz_coord_files/central"
require_relative "us_time_zones/tz_coord_files/eastern"
require_relative "us_time_zones/tz_coord_files/pacific"
require_relative "us_time_zones/tz_coord_files/alaska"
require_relative "us_time_zones/tz_coord_files/mountain"

require "json"
require "httparty"
require "georuby"
# The below may or may not also be necessary; included just in case
require 'geo_ruby/ewk'        # EWKT/EWKB
require 'geo_ruby/shp'        # Shapefile
require 'geo_ruby/gpx'        # GPX data
require 'geo_ruby/kml'        # KML data
require 'geo_ruby/georss'     # GeoRSS
require 'geo_ruby/geojson'    # GeoJSON

Alaska = GeoRuby::SimpleFeatures::Polygon.from_coordinates([ALASKA])
Hawaii_aleutian_1 = GeoRuby::SimpleFeatures::Polygon.from_coordinates([HAWAII_ALEUTIAN_1])
Hawaii_aleutian_2 = GeoRuby::SimpleFeatures::Polygon.from_coordinates([HAWAII_ALEUTIAN_2])
Central = GeoRuby::SimpleFeatures::Polygon.from_coordinates([CENTRAL])
Eastern = GeoRuby::SimpleFeatures::Polygon.from_coordinates([EASTERN])
Pacific = GeoRuby::SimpleFeatures::Polygon.from_coordinates([PACIFIC])
Mountain = GeoRuby::SimpleFeatures::Polygon.from_coordinates([MOUNTAIN])

class TZ
	def self.whichTZ?(point)
		pointObject = GeoRuby::SimpleFeatures::Point.from_x_y(point[0], point[1])
		url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=#{point[0].to_s},#{point[1].to_s}&key=AIzaSyBgUT0t3K3y9cKJgITa8X1O7uGYjguNZT4"
		response = HTTParty.get(url).to_json
		response = JSON.parse(response)

		if response["results"] == []
			return "Error"
		elsif response["results"][0]["formatted_address"].include?("USA")
			if Eastern.contains_point?(pointObject)
				return "US Eastern Time Zone"
			elsif Central.contains_point?(pointObject)
				return "US Central Time Zone"
			elsif Pacific.contains_point?(pointObject)
				return "US Pacific Time Zone"
			elsif Mountain.contains_point?(pointObject)
				return "US Mountain Time Zone"
			elsif Hawaii_aleutian_1.contains_point?(pointObject) || Hawaii_aleutian_2.contains_point?(pointObject)
				return "US Hawaii-Aleutian Time Zone"
			elsif Alaska.contains_point?(pointObject)
				return "US Alaska Time Zone"
			end	
		else
			return "Unable to determine time zone for coordinates outside the US"
		end
	end
end