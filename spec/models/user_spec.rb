require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Validations" do

    before(:each) do
      @user = User.create(first_name: "Ava", last_name: "K", email: "test@test.COM", password: "123456", password_confirmation: "123456")
    end

    it "registration will be vaild when user enter all the required field" do
      expect(@user).to be_valid
    end

    it "email should be unique and not case sensitive" do
      @user2 = User.create(first_name: "Ava", last_name: "K", email: "test@test.COM", password: "123456", password_confirmation: "123456")
      expect(@user2).to be_invalid
      expect(@user2.errors.full_messages).to include("Email has already been taken")

      @user3 = User.create(first_name: "Ava", last_name: "K", email: "TEST@TEST.com", password: "123456", password_confirmation: "123456")
      expect(@user3).to be_invalid
      expect(@user3.errors.full_messages).to include("Email has already been taken")
    end

    it "email shoud not be blank" do
      @user.email = nil
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "first name should not be blank" do
      @user.first_name = nil
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it "last name should not be blank" do
      @user.last_name = nil
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it "password and password_confirmation are required and they should match" do
      @user.password = nil
      @user.password_confirmation = nil
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Password can't be blank", "Password confirmation can't be blank")

      @user.password = "123456"
      @user.password_confirmation = "1234567"
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "password minimun length should be 6 character" do
      @user.password = "12345"
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      
    end

  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
  end

end
