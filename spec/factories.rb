FactoryBot.define do
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
