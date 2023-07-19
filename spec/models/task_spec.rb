require 'rails_helper'

RSpec.describe Task do
  let(:project) { Project.create(name: "My Project") }
  subject { described_class.new(name: 'new Task', description: "new task description", project_id: project.id) }

  describe "Validations" do
    describe "Name" do
      it "must be present" do
        subject.name = nil
        expect(subject).not_to be_valid
      end

      it "must have a minimum length of 3 characters" do
        subject.name = "ab"
        expect(subject).not_to be_valid
      end

      it "must be unique" do
        subject.save
        new_task = described_class.new(name: subject.name, description: "another task", project_id: project.id)
        expect(new_task).not_to be_valid
      end
    end

    describe "Project" do
      it "must be present" do
        subject.project_id = nil
        expect(subject).not_to be_valid
      end
    end

    describe "Description" do
      it "must have a minimum length of 3 characters" do
        subject.description = "ab"
        expect(subject).not_to be_valid
      end

      it "must have a maximum length of 300 characters" do
        subject.description = "a" * 301
        expect(subject).not_to be_valid
      end
    end

    describe "Valid Data" do
      it "should be valid" do
        task = described_class.new(name: 'new Task', description: "new task description", project: project)
        expect(task).to be_valid
      end
    end
  end

  describe "Methods" do
    describe "#start_timer" do
      it "should set the started_at attribute and timer_running to true" do
        subject.start_timer
        expect(subject.started_at).to be_present
        expect(subject.timer_running).to eq(true)
      end
    end

    describe "#stop_timer" do
      it "should set timer_running to false and update the total time" do
        subject.start_timer
        subject.time = 0
        sleep(1)
        subject.stop_timer
        expect(subject.timer_running).to eq(false)
        expect(subject.time).to be > 0
      end
    end

  end
end
