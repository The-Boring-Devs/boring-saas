FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6, max_length: 128) }
    confirmed_at { Time.current }

    trait :locked do
      after(:create) do |user, context|
        user.update(
          locked_at: Time.current,
          failed_attempts: Devise.maximum_attempts + 1,
          unlock_token: context.unlock_token_enc
        )
      end
    end

    transient do
      unlock_token_enc { Devise.token_generator.generate(User, :unlock_token).last }
    end
  end
end
