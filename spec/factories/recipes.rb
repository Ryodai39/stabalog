FactoryBot.define do
  factory :recipe do
    name { "test" }
    price { 630 }
    description { "冬に飲みたくなる、身体が温まるカスタムです" }
    drink { "ダークモカチップフラペチーノ" }
    popularity { 5 }
    association :user
    created_at { Time.current }
  end

  trait :yesterday do
    created_at { 1.day.ago }
  end

  trait :one_week_ago do
    created_at { 1.week.ago }
  end

  trait :one_month_ago do
    created_at { 1.month.ago }
  end
end
