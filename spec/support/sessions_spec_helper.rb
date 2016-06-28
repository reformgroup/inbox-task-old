module SessionsSpecHelper
  def create_login_user(user_role = :user)
    user = create user_role
    login user
    user
  end
  
  def create_login_admin
    create_login_user :admin
  end
  
  def login(user)
    visit login_path
    fill_in 'session[email]',     with: user.email
    fill_in 'session[password]',  with: user.password
    click_button 'Войти'
  end
  
  def logout
    click_link 'Выйти'
  end
end