FactoryBot.define do
  factory :video do
    file { Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/video.mp4") }
    status { nil }
    user

    trait :invalid do
      file { Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/file.txt") }
    end
  end
end
