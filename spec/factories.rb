

FactoryGirl.define do
  factory :user do
    name "test user"
    sequence(:email){|e| "foo#{e}@bar.com"}
    password "secret"
    password_confirmation "secret"
    club_id 1
    referral_count 0
    admin true
  end

  factory :club_leader do
    name "Test Club"
    sequence(:sub_domain){|d| "www#{d}"}
  end

  factory :leader do
    user
    club_leader
    title "president"
  end

  factory :event do
    description "event description"
    title "this event"
    club
    starts_at Date.today
    ends_at Date.tomorrow
  end

  factory :list do
    event
    user
    state "Signed Up"
  end
end

FactoryGirl.define do
  factory :sponsor do
    name "test sponsor"
    image_name "http://link_to.image.com"
    url "http://www.sponsor.com"
    description "some stuff about the sponsor"
  end
end

FactoryGirl.define do
  factory :club do
    name "Test Club"
    sequence(:sub_domain){|d| "www#{d}"}
  end

  factory :notice do
    club
    content "some stuff"
  end
end

FactoryGirl.define do
  factory :subscription do
    email "foo@bar.com"
    stripe_customer_token 1
  end
end



