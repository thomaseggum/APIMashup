require 'net/http'
require 'rexml/document'

class FetchFlightsService
  
  def fetchXml
    require 'net/http'
    require 'rexml/document'

    # Web search for "madonna"
    url = 'http://flydata.avinor.no/XmlFeed.asp?TimeFrom=1&TimeTo=7&airport=OSL&direction=D&lastUpdate=2009-03-10T15:03:00'

    # get the XML data as a string
    xml_data = Net::HTTP.get_response(URI.parse(url)).body

  end

end