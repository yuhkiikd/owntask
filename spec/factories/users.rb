FactoryBot.define do
  factory :user1, class: User do
    id { 10 }
    name { 'test1' }
    email { 'test1@a.com' }
    password { 'hogehoge' }
    admin { true }
  end

  factory :user2, class: User do
    id { 20 }
    name { 'test2' }
    email { 'test2@a.com' }
    password { 'hogehoge' }
    admin { false }
  end

  factory :user3, class: User do
    id { 30 }
    name { 'test3' }
    email { 'test3@a.com' }
    password { 'hogehoge' }
    admin { false }
  end
end