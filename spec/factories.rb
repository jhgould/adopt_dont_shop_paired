FactoryBot.define do
  factory :application do
    name { "Jack" }
    address { "123" }
    city { "Denver" }
    state { "CO" }
    zip { "80204" }
    phone_number { "555-5555" }
    description { "MyString" }
  end
  factory :shelter do
    name { "Angels With Paws" }
    address { "123" }
    city { "Denver" }
    state { "CO" }
    zip { "80204" }
  end

  factory :review do
    title { "Great Shelter" }
    rating {5}
    content {"This place was awesome!"}
    association :followed_by_shelter, factory: :shelter
  end


end
