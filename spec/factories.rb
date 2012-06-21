Factory.define :user do |f|
  f.sequence(:email) {|e| "foo#{e}@example.com"}
  f.name "testuser"
  f.password "secret"
  f.password_confirmation "secret"
end