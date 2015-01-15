require 'spec_helper'
require 'loan'

describe Loan do
  let(:loan) { Loan.new }

  context 'check loan cut-off-date' do
     before do
        loan.due_date = Date.strptime('2014-01-01')
     end

     it 'should return cut-off-date as 31 days later' do
        loan.cut_off_date.should eq(Date.strptime('2014-02-01'))
     end
  end

  context 'a company repaid their debt within the cut_off_date' do
      before do
          loan.due_date = Date.strptime('2014-01-01')
          loan.repayment_date = Date.strptime('2014-01-11')
      end

      it 'should return company as having good credit' do
          loan.timely_repayment?.should eq(true)
      end
  end

  context 'a company repaid their debt after the cut_off_date' do
      before do
          loan.due_date = Date.strptime('2014-01-01')
          loan.repayment_date = Date.strptime('2014-03-11')
      end

       it 'should return company as having bad credit' do
          loan.timely_repayment?.should eq(false)
      end
  end

  context 'a company has not repaid their debt and it\'s after the after the cut_off_date' do
      before do
          loan.due_date = Date.strptime('2014-01-01')
          loan.repayment_date = nil
      end

       it 'should return company as having bad credit' do
          loan.timely_repayment?.should eq(false)
      end
  end

  context 'a company not yet repaid their date but cut_off_date after today' do
      before do
          loan.due_date = Date.strptime('2014-08-04')
          loan.repayment_date = nil
      end

       it 'should return company as having good credit' do
          loan.timely_repayment?.should eq(true)
      end
  end

end
