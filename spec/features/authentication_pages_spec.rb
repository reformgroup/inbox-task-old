require 'rails_helper'
include ApplicationHelper
include CssSpecHelper
include SessionsSpecHelper

RSpec.feature "authentication pages", type: :features do
  
  let(:login_button) { "Войти" }
  let(:login_title) { "Вход" }
  
  scenario "login page" do
    visit login_path

    expect(page).to have_link(login_button)
    expect(page).to have_title(full_title(login_title))
  end
  
  context "login" do
  
    scenario "with invalid information" do
    
      visit login_path
      
      click_button login_button
      
      expect(page).to have_title(full_title(login_title))
      expect(page).to have_selector(alert_danger_css)
    end
    
    scenario "with valid information" do
    
      visit login_path
      
      create_login_user
      
      expect(page).to have_link((login_button))
    end
  end
end
