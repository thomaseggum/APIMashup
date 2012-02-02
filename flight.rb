class Fight
  attr_accessor :city, :time
  
  def initialize(city, time)
    @city = city
    @time = time    
  end
  
  def to_s
    @city + ", " + @time
  end
end
