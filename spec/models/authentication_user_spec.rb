require 'rails_helper'

RSpec.describe AuthenticationUser, type: :model do
  describe "#after_create" do
    before(:each) do
      AuthenticationUser.create
    end
    it "should set api auth token" do
      expect(AuthenticationUser.first.api_auth_token).to be_truthy
    end
  end

end
