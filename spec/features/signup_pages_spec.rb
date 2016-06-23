require 'rails_helper'
include ApplicationHelper
include CssSpecHelper
include SessionsSpecHelper

RSpec.feature "#signup", type: :features do
  
  before { visit signup_path }
  let(:submit) { "Зарегистрироваться" }
  
  context "page" do
    
    scenario { expect(page).to have_link("Регистрация") }
    scenario { expect(page).to have_title(full_title("Регистрация")) }
  end
  
  describe "signup" do
    
    context "with invalid information" do
      
      expect{ click_button submit }.not_to change(User, :count)
      expect(page).to have_title(full_title("Регистрация"))
      expect(page).to have_selector(li_danger_css)
    end
  end
  
  #
  #
  #
  #
  #
  # scenario "signup page" do
  #
  #   visit signup_path
  #
  #   expect(page).to have_link("Регистрация")
  #   expect(page).to have_title(full_title("Регистрация"))
  # end
  #
  # describe "signup" do
  #
  #   scenario "with invalid information" do
  #
  #     visit signup_path
  #
  #     expect{ click_button "Зарегистрироваться" }.not_to change(User, :count)
  #     expect(page).to have_title(full_title("Регистрация"))
  #     expect(page).to have_selector(li_danger_css)
  #   end
  #
  #   scenario "with valid information" do
  #
  #     visit signup_path
  #
  #     @user = build(:user)
  #
  #     fill_in "user[first_name]",                         with: @user.first_name
  #     fill_in "user[last_name]",                          with: @user.last_name
  #     fill_in "user[email]",                              with: @user.email
  #     fill_in "user[password]",                           with: @user.password
  #     fill_in "user[password_confirmation]",              with: @user.password
  #     select I18n.l(@user.birth_date, format: "%-d"), from: "user_birth_date_3i"
  #     select I18n.l(@user.birth_date, format: "%B"),  from: "user_birth_date_2i"
  #     select I18n.l(@user.birth_date, format: "%Y"),  from: "user_birth_date_1i"
  #     choose "user_gender_male"
  #
  #     expect{ click_button "Зарегистрироваться" }.to change(User, :count).by(1)
  #
  #     context "after submission" do
  #
  #       before { click_button "Зарегистрироваться" }
  #
  #       expect(page).to have_title(full_title(@user.short_name))
  #       expect(page).to have_content(@user.name)
  #       expect(page).to have_selector(alert_success_css)
  #       expect(page).to have_link("Выйти")
  #     end
  #   end
  # end
end
