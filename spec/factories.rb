FactoryBot.define do
  factory :application do
    name { "MyString" }
    address { "MyString" }
    city { "MyString" }
    state { "MyString" }
    phone_number { "MyString" }
    description { "MyString" }
  end

  factory :shelter do
    name { "Angels With Paws" }
  end
  factory :review do
    title { "Great Shelter" }
    rating {5}
    content {"This place was awesome!"}
    association :followed_by_shelter, factory: :shelter
  end


end
