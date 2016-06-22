require 'rails_helper'
include ApplicationHelper
include CssSpecHelper
include SessionsSpecHelper

RSpec.describe "main pages", type: :features do
  
  scenario "root page" do
    visit root_path
    
    expect(page).to have_link("Войти", href: login_path(locale: I18n.locale))
    expect(page).to have_link("Регистрация", href: signup_path(locale: I18n.locale))
  end
end