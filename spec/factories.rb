Factory.define :user do |user|
  user.name                  "John Smith"
  user.email                 "user@example.com"
  user.password              "password"
  user.password_confirmation "password"
end