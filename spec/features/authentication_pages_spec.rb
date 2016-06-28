require 'rails_helper'
include ApplicationHelper
include CssSpecHelper
include SessionsSpecHelper

RSpec.feature 'authentication pages', type: :features do
  let(:login_title) { 'Вход' }
  let(:login_button) { 'Войти' }
  let(:logout_button) { 'Выйти' }
  
  before { visit login_path }
  
  context 'login page' do  
    scenario { expect(page).to have_link(login_button) }
    scenario { expect(page).to have_title(full_title(login_title)) }
  end
  describe 'login' do
    context 'with invalid information' do
      before { click_button login_button }
      
      scenario { expect(page).to have_title(full_title(login_title)) }
      scenario { expect(page).to have_selector(alert_danger_css) }
    end
    context 'with valid information' do
      before { create_login_user }
      
      scenario { expect(page).not_to have_link((login_button)) }
      scenario { expect(page).to have_link((logout_button)) }
    end
  end
end
