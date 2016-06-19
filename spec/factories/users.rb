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

FactoryGirl.define do
  factory :user do
    last_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }
    middle_name "Konstantinovich"
    email { Faker::Internet.email }
    birth_date { 18.years.ago - Faker::Number.number(3).to_i.days }
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
    
    factory :me do
      last_name "Константинопольский"
      first_name "Константин"
      middle_name "Константинович"
      email "test@mail.com"
      gender "male"
      password "123123"
      password_confirmation "123123"
      role "superadmin"
      avatar { process_uri(Faker::Avatar.image) }
    end
  end
end
