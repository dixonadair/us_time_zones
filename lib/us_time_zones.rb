require "us_time_zones/version"

module UsTimeZones
	def self.getZone(lat)
		if lat == 1
			return "yes"
		else
			return "no"
		end
	end
end