json.extract! task, :id, :name, :description, :project_id, :time, :created_at, :updated_at
json.url task_url(task, format: :json)
