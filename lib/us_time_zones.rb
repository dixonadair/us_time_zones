require "us_time_zones/version"

require_relative "us_time_zones/tz_coord_files/hawaii_aleutian_1"
require_relative "us_time_zones/tz_coord_files/hawaii_aleutian_2"
require_relative "us_time_zones/tz_coord_files/central"
require_relative "us_time_zones/tz_coord_files/eastern"
require_relative "us_time_zones/tz_coord_files/pacific"
require_relative "us_time_zones/tz_coord_files/alaska"

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

class TZ
	def self.whichTZ?(point)
		alaska = GeoRuby::SimpleFeatures::Polygon.from_coordinates([ALASKA])
		hawaii_aleutian_1 = GeoRuby::SimpleFeatures::Polygon.from_coordinates([HAWAII_ALEUTIAN_1])
		hawaii_aleutian_2 = GeoRuby::SimpleFeatures::Polygon.from_coordinates([HAWAII_ALEUTIAN_2])
		central = GeoRuby::SimpleFeatures::Polygon.from_coordinates([CENTRAL])
		eastern = GeoRuby::SimpleFeatures::Polygon.from_coordinates([EASTERN])
		pacific = GeoRuby::SimpleFeatures::Polygon.from_coordinates([PACIFIC])
		
		pointObject = GeoRuby::SimpleFeatures::Point.from_x_y(point[0], point[1])
		url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=#{point[0].to_s},#{point[1].to_s}&key=AIzaSyBgUT0t3K3y9cKJgITa8X1O7uGYjguNZT4"
		response = HTTParty.get(url).to_json
		response = JSON.parse(response)

		if response["results"] == []
			p "Error"
		elsif response["results"][0]["formatted_address"].include?("USA")
			p "You're in the USA"
			if eastern.contains_point?(pointObject)
				p "Eastern Time Zone"
			elsif central.contains_point?(pointObject)
				p "Central Time Zone"
			elsif pacific.contains_point?(pointObject)
				p "Pacific Time Zone"
			elsif hawaii_aleutian_1.contains_point?(pointObject) || hawaii_aleutian_2.contains_point?(pointObject)
				p "Hawaii-Aleutian Time Zone"
			elsif alaska.contains_point?(pointObject)
				p "Alaska Time Zone"
			else
				p "Mountain Time Zone"
			end	
		else
			p "You're not in the USA"
		end

		# puts polygon.contains_point?(point)
	end
end