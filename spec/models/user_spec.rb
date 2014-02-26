require "spec_helper"

describe User do
  it { expect(build(:user)).to validate_presence_of(:email) }
  it { expect(build(:user)).to validate_presence_of(:encrypted_password) }
  it { expect(create(:user)).to validate_uniqueness_of(:email) }
  it { expect(create(:user)).to validate_uniqueness_of(:uuid) }
  it { expect(create(:user)).to validate_uniqueness_of(:auth_token) }

  it "should generate uuid" do
    user = create(:user)
    expect(user.uuid).to_not be_nil
  end

  it "should generate auth_token" do
    user = create(:user)
    expect(user.auth_token).to_not be_nil
  end
end
