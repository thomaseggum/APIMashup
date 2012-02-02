require 'net/http'
require 'json'
require 'xmlsimple'

class FetchFlightsService
  
  @@airport_names = nil
  @@airline_names = nil
  
  def fetchXml
    if  !@@airport_names || !@@airline_names
      p "fetching airportnames and airline names"
      @@airport_names = fetchDataFromUrl("http://flydata.avinor.no/airportNames.asp")["airportName"].to_hash_values {|v| v["code"]}
      @@airline_names = fetchDataFromUrl("http://flydata.avinor.no/airlineNames.asp")["airlineName"].to_hash_values {|v| v["code"]}
    end
 
    flights = fetchDataFromUrl("http://flydata.avinor.no/XmlFeed.asp?TimeFrom=1&TimeTo=7&airport=OSL&direction=D&lastUpdate=2009-03-10T15:03:00")["flights"][0]["flight"]
    flights_array = Array.new
    flights.each do | flight |
      flight_object = {"city" => @@airport_names[flight["airport"][0]], "time" => Time.parse(flight["schedule_time"][0]).strftime("%H:%M")}
      flights_array << flight_object
    end
    
    flights_array.to_json
  end

  def fetchDataFromUrl(url)
    xml_data = Net::HTTP.get_response(URI.parse(url)).body.to_s
    XmlSimple.xml_in(xml_data)
  end

end

class Array
    def to_hash_values(&block)
      Hash[*self.collect { |v|
        [block.call(v), v["name"]]
      }.flatten]
    end
end

