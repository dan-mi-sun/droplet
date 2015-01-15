require 'date'
require 'company'
require 'loan'

class CreditScoring
  def initialize(companies_path, loans_path)
  end

  #
  # List of companies who returned all their loans max. 31 days later
  # then expected due date. If the due date is later then today and payment
  # wasn't done yet, lets not rule out companies who still have enough 
  # time to pay (date is later then 31 days in the future).
  #
  
  def clear_companies
     Company.credit_worthy?
  end

  #
  # List of companies who have at the moment more then specified amount on
  # the bank account. Its a sum of all money company had borrowed and from
  # other companies which are not paid yet - amount company lended to other
  # companies which are not paid yet.
  #
  # Every company started with 0 balance.
  #
  def companies_with_balance(min)
    Company.account_balance <= min 
  end
end