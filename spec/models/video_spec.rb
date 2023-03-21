RSpec.describe Video, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_timestamps }
  it { is_expected.to have_field(:file_data).of_type(String) }
  it { is_expected.to have_field(:status).of_type(String) }
  it { is_expected.to belong_to(:user) }
end
