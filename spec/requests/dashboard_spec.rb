require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) do
    User.create!(
      name: "Test",
      email: "test@example.com",
      password: "password",
      employee_id: "E1",
      role: :employee
    )
  end

  before { sign_in user }

  describe "GET /show" do
    it "returns http success" do
      get "/dashboard"
      expect(response).to have_http_status(:success)
    end
  end
end
