require "rails_helper"

RSpec.describe ContactDetails do

  it "not allow invalid email addresses" do
    expect(ContactDetails.new(email: "invalid_email").valid?).to be_falsey
  end

  it "allow valid email addresses" do
    expect(ContactDetails.new(email: "valid@email.com").valid?).to be_truthy
  end
end
