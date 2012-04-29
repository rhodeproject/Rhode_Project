def make_users
  admin = User.create!(name: "Moderator",
                       email: "matt@rhodeproject.com",
                       password: "foobar",
                       password_confirmation: "foobar")
  admin.toggle!(:admin)
end