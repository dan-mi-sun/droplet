require 'date'

class Loan

    attr_accessor :lender
    attr_accessor :borrower
    attr_accessor :amount
    attr_accessor :issue_date
    attr_accessor :due_date
    attr_accessor :repayment_date

  def self.loans_file_path
    'data/loans.txt'
  end

  def self.all
      companies = Company.all
      all = File.read(self.loans_file_path).scan(/(.+) (.+) (.+) (.+) (.+) (.+)/)
      all.map do |row|
            loan = Loan.new
            loan.lender = companies.select { |c| c.company_number == row[0] }.first
            loan.borrower =  companies.select { |c| c.company_number == row[1] }.first
            loan.amount = row[2].to_i
            loan.issue_date = row[3]
            loan.due_date = Date.strptime(row[4])
            begin
                if row[5]
                    loan.repayment_date = Date.strptime(row[5])
                end
            rescue StandardError=>e
            end
            loan
        end

  end

  def cut_off_date
      self.due_date + 31
  end

  def timely_repayment?
    unless repayment_date.nil?
        cut_off_date - repayment_date > 0
    else
        cut_off_date > Date.today
    end
  end

  def late_repayment?
      unless repayment_date.nil?
         cut_off_date - repayment_date < 0
      else
         cut_off_date < Date.today
      end
  end

end
