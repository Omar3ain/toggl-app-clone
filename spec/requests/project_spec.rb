require 'rails_helper'

RSpec.describe "Project Routes", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, user: user) }

  describe "GET /projects" do
    it "should return projects when logged in" do
      sign_in user

      get '/projects'

      expect(response).to have_http_status(200)
    end

    it "should redirect when not logged in" do
      get '/projects'
      expect(response).to have_http_status(302)
    end
  end

  describe "GET /projects/:id" do
    it "should return the project" do
      sign_in user

      get "/projects/#{project.id}"

      expect(response).to have_http_status(200)
    end
  end

  describe "POST /projects" do
    it "should create a new project" do
      sign_in user

      post "/projects", params: { project: { name: "New Project", user_id: user.id } }

      expect(response).to have_http_status(302)
      expect(Project.last.name).to eq("New Project")
    end
  end

  describe "PUT /projects/:id" do
    it "should update the project" do
      sign_in user

      put "/projects/#{project.id}.json", params: { project: { name: "Updated Project" } }

      expect(response).to have_http_status(200)
      expect(Project.find(project.id).name).to eq("Updated Project")
    end
  end

  describe "DELETE /projects/:id" do
    it "should delete the project" do
      sign_in user

      delete "/projects/#{project.id}"

      expect(response).to have_http_status(302)
      expect(Project.exists?(project.id)).to be_falsey
    end
  end

  describe "GET /projects/:id/project_tasks" do
    it "should return project tasks and total time" do
      sign_in user

      get "/projects/#{project.id}/project_tasks", headers: { "ACCEPT" => "application/json" }

      parsed_response = JSON.parse(response.body)
      tasks = parsed_response["tasks"]
      total_time = parsed_response["total_time"]

      expect(response).to have_http_status(200)
      expect(tasks).to be_an(Array)
      expect(total_time).to be_an(Integer)
    end
  end




end
