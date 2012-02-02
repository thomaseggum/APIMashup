require 'net/http'
require 'json'
require 'xmlsimple'

class FetchFlightsService
  
  @@airport_names = nil
  @@airline_names = nil
  
  def fetch_airport_names
    @@airport_names || fetchDataFromUrl("http://flydata.avinor.no/airportNames.asp")["airportName"].to_hash_values {|v| v["code"]}
  end
  
  def fetchXml(iata, direction)
    if  !@@airport_names || !@@airline_names
      p "fetching airportnames and airline names"
      @@airport_names = fetchDataFromUrl("http://flydata.avinor.no/airportNames.asp")["airportName"].to_hash_values {|v| v["code"]}
      @@airline_names = fetchDataFromUrl("http://flydata.avinor.no/airlineNames.asp")["airlineName"].to_hash_values {|v| v["code"]}
    end
  
    xml_api_url = iata == "RYG" ? "http://www.ryg.no/files/ryg.no/flytider/xmlfeed.aspx" : "http://flydata.avinor.no/XmlFeed.asp"
 
    p "XML API = #{xml_api_url}"
    flights = fetchDataFromUrl("#{xml_api_url}?TimeFrom=2&TimeTo=4&airport=#{iata.upcase}&direction=#{direction}")["flights"][0]["flight"]
    flights_array = Array.new
    flights.each do | flight |
      flight_object = {"city" => @@airport_names[flight["airport"][0]], 
                      "time" => (Time.parse(flight["schedule_time"][0]+" UTC").gmtime + 3600).strftime("%H:%M")}
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

