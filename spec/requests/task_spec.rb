require 'rails_helper'

RSpec.describe "Tasks Routes", type: :request do
  describe "GET /tasks" do
    it "should return tasks when logged in" do
      user = User.create(email: "user@example.com", password: "password")
      sign_in user

      get '/tasks.json'

      # Expect the response body to contain the created task
      expect(JSON.parse(response.body)).to eql([])

    end

    it "should redirect when not logged in" do
      get '/tasks'
      expect(response).to have_http_status(302)
    end
  end

  describe "GET /tasks/:id" do
    it "should return the task" do
      user = User.create(email: "user@example.com", password: "password")
      sign_in user

      project = FactoryBot.create(:project, user: user)
      task = FactoryBot.create(:task, id: 2, name: "Task 1", description: "Description 1", project_id: project.id)

      get "/tasks/#{task.id}.json"

      # Expect the response body to contain the task
      expect(JSON.parse(response.body)).to eql({
        "id" => task.id,
        "name" => task.name,
        "description" => task.description,
        "project_id" => task.project_id,
        "time" => task.time,
        "created_at" => task.created_at.as_json,
        "updated_at" => task.updated_at.as_json,
        "url" => "http://www.example.com/tasks/#{task.id}.json"
      })

    end
  end

  describe "POST /tasks" do
    it "should create a new task" do
      user = User.create(email: "user@example.com", password: "password")
      sign_in user

      project = FactoryBot.create(:project, user: user)

      post "/tasks", params: { task: { name: "New Task", description: "New Description", project_id: project.id, time: 0 } }

      expect(response).to have_http_status(302)
      expect(Task.last.name).to eq("New Task")
      expect(Task.last.description).to eq("New Description")
      expect(Task.last.project_id).to eq(project.id)
      expect(Task.last.time).to eq(0)
    end
  end

  describe "PUT /tasks/:id" do
    it "should update the task" do
      user = User.create(email: "user@example.com", password: "password")
      sign_in user

      project = FactoryBot.create(:project, user: user)
      task = FactoryBot.create(:task, project: project)

      patch "/tasks/#{task.id}.json", params: { task: { name: "Updated Task", description: "Updated Description" } }

      # expect(response).to have_http_status(302)
      expect(Task.find(task.id).name).to eq("Updated Task")
      expect(Task.find(task.id).description).to eq("Updated Description")
    end
  end

  describe "DELETE /tasks/:id" do
    it "should delete the task" do
      user = User.create(email: "user@example.com", password: "password")
      sign_in user

      project = FactoryBot.create(:project, user: user)
      task = FactoryBot.create(:task, project: project)

      delete "/tasks/#{task.id}"

      expect(response).to have_http_status(302)
      expect(Task.exists?(task.id)).to be_falsey
    end
  end
end
