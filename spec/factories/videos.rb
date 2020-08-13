FactoryBot.define do
  factory :video do
    file { nil }
    status { nil }
    user
  end
end
