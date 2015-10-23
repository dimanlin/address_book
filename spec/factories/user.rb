FactoryGirl.define do
  sequence :first_name do |n|
    "first_name_#{n}"
  end

  sequence :last_name do |n|
    "last_name_#{n}"
  end

  sequence :email do |n|
    "user#{n}@example.com"
  end

  sequence :phone_numbers do |n|
    "8(926)123-45-6#{n}"
  end

  factory :user do
    first_name { FactoryGirl.generate(:first_name) }
    last_name { FactoryGirl.generate(:last_name) }
    emails { [FactoryGirl.generate(:email)] }
    phone_numbers { [FactoryGirl.generate(:phone_numbers)] }
  end
end




