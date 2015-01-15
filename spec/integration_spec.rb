require 'spec_helper'
require 'credit_scoring'

describe CreditScoring do
  let(:credit_scoring) { CreditScoring.new('data/companies.txt', 'data/loans.txt') }

  it 'should return list of companies with clear credit score (return all money no later then 31 days' do
    credit_scoring.clear_companies.map(&:name).should eq [
      "Nostalgia Consultancy Limited"
    ]

  end

  it 'should return a list of companies who have got 15M+ at the moment' do
    credit_scoring.companies_with_balance(15_000_000).map(&:name).should eq [
      "Excellpak Limited", "Accessible Designs.Adjustable Systems Inc. Limited", "Street Culture Records Limited"
    ]
  end
end
