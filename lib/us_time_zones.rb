require "us_time_zones/version"

require_relative "us_time_zones/tz_coord_files/hawaii_aleutian"
# require "us_time_zones/tz_coord_files/alaska"
# require "us_time_zones/tz_coord_files/pacific"
# require "us_time_zones/tz_coord_files/central"
# require "us_time_zones/tz_coord_files/eastern"

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

class TZ
	def pointInPolygon?(shape_coords_arr, point)
		polygon = GeoRuby::SimpleFeatures::Polygon.from_coordinates()
		polygon
	end
end