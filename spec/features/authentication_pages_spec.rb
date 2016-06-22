require 'rails_helper'
include ApplicationHelper
include CssSpecHelper
include SessionsSpecHelper

RSpec.feature "authentication pages", type: :features do
  
  scenario "login page" do
    visit login_path

    expect(page).to have_link("Войти")
    expect(page).to have_title(full_title("Вход"))
  end
  
  context "login" do
  
    scenario "with invalid information" do
    
      visit login_path
      
      click_button "Войти"
      
      expect(page).to have_title(full_title("Вход"))
      expect(page).to have_selector(alert_danger_css)
    end
    
    scenario "with valid information" do
    
      visit login_path
      
      create_login_user
      
      expect(page).to have_link(("Выйти"))
    end
  end
end
