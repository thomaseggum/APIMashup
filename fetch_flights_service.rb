require 'net/http'
require 'json'

class FetchFlightsService
  
  @@airport_names = nil
  @@airline_names = nil
  
  def fetchXml
    if  !@@airport_names || @@airline_names
      p "fetching airportnames and airline names"
      @@airport_names = fetchDataFromUrl("http://flydata.avinor.no/airportNames.asp")
      @@airline_names = fetchDataFromUrl("http://flydata.avinor.no/airlineNames.asp")
    end
 
    flights = fetchDataFromUrl("http://flydata.avinor.no/XmlFeed.asp?TimeFrom=1&TimeTo=7&airport=OSL&direction=D&lastUpdate=2009-03-10T15:03:00")
    flights.to_s
  end

  def fetchDataFromUrl(url)
    xml_data = Net::HTTP.get_response(URI.parse(url)).body.to_s
  end

end