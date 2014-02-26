FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "test_email#{n}@example.com"  }
    password              "super_secret"
  end
end
