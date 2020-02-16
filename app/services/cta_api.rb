class CtaApi
  include HTTParty
  base_uri 'http://www.transitchicago.com/api/1.0'


  def transit_routes 
    self.class.get("/routes.aspx", @options)
  end 



  def initialize
    @options = {responseType: "JSON"}
    # @response_body = JSON.parse(@response.body)
  end

end
