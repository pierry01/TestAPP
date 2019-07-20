FactoryBot.define do
  factory :customer, aliases: [:user] do
    transient do
      upcased { false }
    end
  
    name { Faker::Name.name }
    sequence(:email) { |n| "meu_email-#{n}@email.com" }
    vip { false }
    days_to_pay { 15 }

    trait :male do
      gender { 'M' }
    end
    
    trait :female do
      gender { 'F' }
    end
    
    trait :vip do
      vip { true }
      days_to_pay { 30 }
    end
    
    factory :customer_male, traits: [:male]
    factory :customer_female, traits: [:female]
    factory :customer_vip, traits: [:vip]
    factory :customer_male_vip, traits: [:male, :vip]
    factory :customer_female_vip, traits: [:female, :vip]
    
    after(:create) do |customer, evaluator|
      customer.name.upcase! if evaluator.upcased
    end
  end
end