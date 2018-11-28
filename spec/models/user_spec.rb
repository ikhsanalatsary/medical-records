require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  # Validation tests
  # ensure name, email and password_digest are present before save
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:username) }
  # it { is_expected.to enumerize(:roles).in(:patient, :doctor, :admin).with_default(:patient) }
end
