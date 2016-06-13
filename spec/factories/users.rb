FactoryGirl.define do
  factory :user do
    first_name "Foo"
    last_name "Bar"
    email "foobar@mail.com"
    birth_date { 18.years.ago }
    gender "male"
    password "foobar"
    password_confirmation "foobar"
    role "user"
    
    factory :admin do
      role "admin"
    end
    
    factory :superadmin do
      role "superadmin"
    end
  end

end
