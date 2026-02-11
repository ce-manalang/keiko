require 'rails_helper'

RSpec.describe "Homes", type: :request do
  include Devise::Test::IntegrationHelpers
  let(:user) { User.create!(name: "T", email: "t@t.com", password: "password", employee_id: "T1", role: :employee) }
  before { sign_in user }

  describe "GET /index" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end
end
