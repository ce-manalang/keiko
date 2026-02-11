require 'rails_helper'

RSpec.describe "Users", type: :request do
  include Devise::Test::IntegrationHelpers

  let(:scheduler) do
    User.create!(
      name: "Admin",
      email: "admin@example.com",
      password: "password",
      employee_id: "S1",
      role: :scheduler
    )
  end

  before do
    sign_in scheduler
  end

  describe "GET /" do
    it "returns http success" do
      get "/users"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/users/#{scheduler.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/users/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http success" do
      post "/users", params: { user: { name: "New User", email: "new@test.com", password: "password", employee_id: "E99", role: "employee" } }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/users/#{scheduler.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /update" do
    it "returns http success" do
      patch "/users/#{scheduler.id}", params: { user: { name: "Updated Name" } }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "DELETE /destroy" do
    it "returns http success" do
      delete "/users/#{scheduler.id}"
      expect(response).to have_http_status(:redirect)
    end
  end
end
