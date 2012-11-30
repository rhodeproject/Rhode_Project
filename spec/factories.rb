

FactoryGirl.define do
  factory :user do
    name "test user"
    sequence(:email){|e| "foo#{e}@bar.com"}
    password "secret"
    password_confirmation "secret"
    club_id 1
  end
end

FactoryGirl.define do
  factory :club do
    name "Test Club"
    sub_domain "www"
  end
end

