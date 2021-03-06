Factory.define :user do |user|
  user.name                  "John Smith"
  user.email                 "user@example.com"
  user.password              "password"
  user.password_confirmation "password"
end

Factory.define :user_with_task, class: User do |user|
  user.name                  "Pol Mc"
  user.email                 "user2@example.com"
  user.password              "password"
  user.password_confirmation "password"
  user.tasks {|tasks| [tasks.association(:task)]}
end


Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :task do |task|
  task.title "Foo"
  task.content "Foo bar"
end
