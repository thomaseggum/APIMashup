require 'sinatra'
require File.dirname(__FILE__) + "/fetch_flights_service"

configure :production do
  
end

get '/' do
  fetchFlightsService = FetchFlightsService.new
  fetchFlightsService.fetchXml
end

