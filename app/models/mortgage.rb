class Mortgage < ApplicationRecord
  has_many :condos 
  validates :rate, :years, presence: true 


  def months 
    return self.years * 12 
  end 

    #c in the calc
  def rate_over_year 
    #since it is spread out over the year
    self.rate_calc / 12
  end 

  alias c rate_over_year

  def rate_calc 
    #so users can write it nicely
    return self.rate / 100
  end 

end
