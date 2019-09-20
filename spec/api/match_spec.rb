require 'rails_helper'

RSpec.describe "matches api", :vcr, api: true, accounts: true, type: :request do
  let(:user) { AuthenticationUser.create }
  matches_json = JSON.parse(File.read("./spec/fixtures/matches_data.json"))

  describe "GET /matches" do
    let!(:match) { Match.create(:data => matches_json, :league_id => "PD") }
    before(:each) do
      get "/matches",
        headers: { "X-API-Auth-Token" => user.api_auth_token}
    end

    it "should return match data" do
      expect(JSON.parse(response.body)).to be_truthy
      expect(JSON.parse(response.body).count).to eq(1)
      expect(JSON.parse(response.body)[0].keys).to eq(["id", "league_id", "data"])
    end

  end

  describe "GET /matches/MATCH_ID" do
    let!(:match) { Match.create(:data => matches_json, :league_id => "PD") }

    context "regular find" do
      before(:each) do
        get "/matches/PD",
          headers: { "X-API-Auth-Token" => user.api_auth_token}
      end

      it "should return match data" do
        expect(JSON.parse(response.body)).to be_truthy
        expect(JSON.parse(response.body).keys).to eq(["id", "league_id", "data"])
      end
    end

    context "find with team params" do
      before(:each) do
        get "/matches/PD",
          headers: { "X-API-Auth-Token" => user.api_auth_token},
          params: {:team_id => 81} # 81 is barcelona
      end

      it "should return match data" do
        expect(JSON.parse(response.body)["data"].count).to eq(38)
        expect(JSON.parse(response.body).keys).to eq(["id", "league_id", "data"])
        JSON.parse(response.body)["data"].each do |m|
          expect(m["homeTeam"]["id"] == 81 || m["awayTeam"]["id"] == 81).to eq(true)
        end
      end
    end

  end

end
