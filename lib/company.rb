require 'date'

class Company

  attr_accessor :name
  attr_accessor :company_number

  def self.company_file_path
    'data/companies.txt'
  end

  def self.all
      all = File.read(self.company_file_path).scan(/(.+) (.+)/)
      all.map do |row|
        company = Company.new
        company.name = row[0]
        company.company_number = row[1]
        company
    end
  end

   def self.credit_worthy?
     loans = Loan.all
     on_time_repayments = loans.select { |l| l.timely_repayment? }.map { |l| l.borrower }.uniq
     late_repayments = loans.select { |l| l.late_repayment? }.map { |l| l.borrower }.uniq
     credit_worthy = on_time_repayments - late_repayments
     credit_worthy
  end

  def borrowed_amt
    Loan.all.select { |l| (l.borrower.eql?(self)) && l.repayment_date.nil? }.map { |l| l.amount }.inject(:+) || 0
  end

  def lent_amt
    Loan.all.select { |l| (l.lender.eql?(self)) && l.repayment_date.nil? }.map { |l| l.amount }.inject(:+) || 0
  end

  def account_balance
    borrowed_amt - lent_amt
  end

  def eql?(other_company)
      self.company_number.eql?(other_company.company_number)
  end

  def hash
     self.company_number.hash
  end

end
