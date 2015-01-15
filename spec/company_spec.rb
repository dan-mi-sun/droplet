require 'spec_helper'
require 'company'

describe Company do
  let(:companies) { Company.new }

  it 'should return an array of all companies'do
      Company.stubs(:company_file_path).returns('data/companies_test.txt')
  	  Company.all.length.should eq(3)
  	  Company.all.first.is_a?(Company).should eq(true)
  end

   describe '#borrowed_amt' do

     before do
         companies.name = "Excellpak Limited"
         companies.company_number = "00007941"
     end

     it 'should calculate amt company has borrowed' do

          Company.stubs(:company_file_path).returns('data/companies_test.txt')
          Loan.stubs(:loans_file_path).returns('data/loans_test.txt')

          companies.borrowed_amt.should eq(100)

     end
  end

  describe '#lent_amt' do

     before do
         companies.name = "Excellpak Limited"
         companies.company_number = "00007941"
     end

     it 'should calculate amt company has lent' do

          Company.stubs(:company_file_path).returns('data/companies_test.txt')
          Loan.stubs(:loans_file_path).returns('data/loans_test.txt')

          companies.lent_amt.should eq(130)

     end
  end

  describe '#account_balance' do

     before do
         companies.name = "Excellpak Limited"
         companies.company_number = "00007941"
     end

     it 'should calculate company account balance' do

          Company.stubs(:company_file_path).returns('data/companies_test.txt')
          Loan.stubs(:loans_file_path).returns('data/loans_test.txt')

          companies.account_balance.should eq(-30)

     end
  end

end
