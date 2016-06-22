# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  last_name           :string           not null
#  first_name          :string           not null
#  middle_name         :string
#  email               :string           not null
#  gender              :integer          not null
#  birth_date          :date             not null
#  password_digest     :string           not null
#  remember_digest     :string
#  role                :integer          not null
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  deleted_at          :datetime
#  creator_id          :integer
#  updater_id          :integer
#  deleter_id          :integer
#

require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = build(:user) }

  subject { @user }
  
  it { should respond_to(:last_name) }
  it { should respond_to(:first_name) }
  it { should respond_to(:middle_name) }
  it { should respond_to(:email) }
  it { should respond_to(:gender) }
  it { should respond_to(:birth_date) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:remember_digest) }
  it { should respond_to(:role) }
  it { should respond_to(:avatar_file_name) }
  it { should respond_to(:avatar_content_type) }
  it { should respond_to(:avatar_file_size) }
  it { should respond_to(:avatar_updated_at) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should respond_to(:deleted_at) }
  it { should respond_to(:creator_id) }
  it { should respond_to(:updater_id) }
  it { should respond_to(:deleter_id) }
  
  it { should be_valid }
  
  # Last name
  context "when last name is not present" do
    it "should be invalid" do
      @user.last_name = " "
      expect(@user).not_to be_valid
    end
  end
  
  context "when last name format is invalid" do
    it "should be invalid" do
      name = %w[foo123 ,foo foo,bar]
      name.each do |i|
        @user.last_name = i
        expect(@user).not_to be_valid
      end
    end
  end
  
  context "when last name format is valid" do
    it "should be valid" do
      name = %w[Foo fOO foo Foo-Bar Константинопольский]
      name.each do |i|
        @user.last_name = i
        expect(@user).to be_valid
      end
    end
  end

  # First name
  context "when first name is not present" do
    it "should be invalid" do
      @user.first_name = " "
      expect(@user).not_to be_valid
    end
  end
  
  context "when first name format is invalid" do
    it "should be invalid" do
      name = %w[foo123 ,foo foo,bar]
      name.each do |i|
        @user.first_name = i
        expect(@user).not_to be_valid
      end
    end
  end
  
  context "when first name format is valid" do
    it "should be valid" do
      name = %w[Foo fOO foo Foo-Bar Константин]
      name.each do |i|
        @user.first_name = i
        expect(@user).to be_valid
      end
    end
  end
  
  # Middle name
  context "when middle name is not present" do
    it "should be invalid" do
      @user.middle_name = " "
      expect(@user).not_to be_valid
    end
  end
  
  context "when middle name format is invalid" do
    it "should be invalid" do
      name = %w[foo123 ,foo foo,bar]
      name.each do |i|
        @user.middle_name = i
        expect(@user).not_to be_valid
      end
    end
  end
  
  context "when middle name format is valid" do
    it "should be valid" do
      name = %w[Foo fOO foo Foo-Bar Константин]
      name.each do |i|
        @user.middle_name = i
        expect(@user).to be_valid
      end
    end
  end
  
  # Email
  context "when email is not present" do
    it "should be invalid" do
      @user.email = " "
      expect(@user).not_to be_valid
    end
  end
  
  context "when email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end
  
  context "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  context "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end
  
  context "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end
  
  # Birth date
  context "when birth date is not present" do
    it "should be invalid" do
      @user.birth_date = " "
      expect(@user).not_to be_valid
    end
  end
  
  context "when birth date format is invalid" do
    it "should be valid" do
      dates = %w[deew-12-12 0000-00-00 FooBar]
      dates.each do |i|
        @user.birth_date = i
        expect(@user).not_to be_valid
      end
    end
  end

  context "when birth date format is valid" do
    it "should be valid" do
      @user.birth_date = 18.years.ago
      expect(@user).to be_valid
    end
  end
  
  # Password
  context "when password is not present" do
    it "should be invalid" do
      @user.password = @user.password_confirmation = " "
      expect(@user).not_to be_valid
    end
  end
  
  context "when password doesn't match confirmation" do
    it "should be invalid" do
      @user.password_confirmation = "mismatch"
      expect(@user).not_to be_valid
    end
  end

  context "with a password that's too short" do
    it "should be invalid" do
      @user.password = @user.password_confirmation = "a" * 5
      expect(@user).not_to be_valid
    end
  end
  
  # Authenticate method
  context "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    context "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    context "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be false }
    end
  end
end
