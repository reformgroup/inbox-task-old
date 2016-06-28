require 'rails_helper'
include ApplicationHelper
include CssSpecHelper
include SessionsSpecHelper

RSpec.describe 'main pages', type: :features do
  let(:login) { 'Войти' }
  let(:signup) { 'Регистрация' }
  
  before { visit signup_path }
  
  context 'root page' do
    scenario { expect(page).to have_link(login, href: login_path(locale: I18n.locale)) }
    scenario { expect(page).to have_link(signup, href: signup_path(locale: I18n.locale)) }
  end
end