require 'sinatra'
require File.dirname(__FILE__) + "/fetch_flights_service"

configure :production do
  
end

@@fetchFlightsService = FetchFlightsService.new

get '/:iata/:direction' do
  fetchFlightsService = FetchFlightsService.new
  fetchFlightsService.fetchXml(params[:iata], params[:direction])
end

get '/airports' do
    @@fetchFlightsService.fetch_airport_names.to_json
end

