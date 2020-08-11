class Condo < ApplicationRecord
  belongs_to :mortgage
  before_create :set_default_tax

  DOWN_PAYMENT = 120000

  def payment 
    self.price 
  end

  def loan_amount 
    return 0 if self.price - Condo::DOWN_PAYMENT < 0 
    self.price - Condo::DOWN_PAYMENT
  end 
  
  alias l loan_amount

  def set_tax 
    #12 months 
    #tax rate from the mortgage sheet 
    self.price * (0.0175/12)
  end 

  def remaining_balance(months)
    m = months 
    c = self.mortgage.rate_over_year
    n = self.mortgage.months
    balance = l * (( ((1 + c)**n) - ((1 + c)**m)) / (((1 + c)**n) - 1))
    return 0 if balance < 0 
    return balance.round(6)
  end

  def total_load_paid 
    self.monthly_mortgage_payment * self.mortgage.months 
  end 

  def total_interest_paid 
    self.total_load_paid - self.loan_amount 
  end 

  def total_cost_paid
    self.price + self.total_interest_paid
  end 

  def monthly_mortgage_payment 
    c = self.mortgage.rate_over_year
    n = self.mortgage.months
    payment = l * ((c*(1 + c)**n) / (((1 + c)**n) - 1))
    payment.round(6)
  end 

  private 

  def set_default_tax 
    self.tax = self.set_tax unless self.tax?
  end 
  

end
