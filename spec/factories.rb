Factory.define :user do |user|
  user.name                  "John Smith"
  user.email                 "user@example.com"
  user.password              "password"
  user.password_confirmation "password"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :task do |task|
  task.name "Foo"
  task.content "Foo bar"
  task.association :user
end
