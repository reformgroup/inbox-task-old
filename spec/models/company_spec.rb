# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#  creator_id :integer
#  updater_id :integer
#  deleter_id :integer
#

require 'rails_helper'

RSpec.describe Company, type: :model do
  before { @company = build(:company) }

  subject { @company }
  
  it { should respond_to(:name) }
  it { should be_valid }
  
  # Name
  context "when name is not present" do
    it "should be invalid" do
      @company.name = " "
      expect(@company).not_to be_valid
    end
  end
  
  context "when last name format is invalid" do
    it "should be invalid" do
      name = %w[± ! @ # $ % ^ & * ( ) { } [ ] | : ; ' " < > ? ~ `]
      name.each do |i|
        @company.name = i
        expect(@company).not_to be_valid
      end
    end
  end
  
  context "when last name format is valid" do
    it "should be valid" do
      name = ["Foo", "fOO", "foo", "Foo-Bar", "CJB Foo Bar"]
      name.each do |i|
        @company.name = i
        expect(@company).to be_valid
      end
    end
  end
end
