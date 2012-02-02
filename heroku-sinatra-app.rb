require 'sinatra'

configure :production do

end

get '/' do
  {
  	flight : {
  		destination: "Trondheim",
  		origin: "Oslo", 
  		time: "12:00"
  	}
  }
end
