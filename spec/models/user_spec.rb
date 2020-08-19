RSpec.describe User, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_timestamps }
  it { is_expected.to have_index_for(email: 1).with_options(unique: true) }
  it { is_expected.to have_field(:email).of_type(String) }
  it { is_expected.to have_many(:videos).with_dependent(:destroy) }
end
