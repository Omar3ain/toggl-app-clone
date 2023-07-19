require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:user) { User.create(email: 'user@example.com', password: 'password') }

  subject { described_class.new(name: 'new Task', user_id: user.id) }

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
        new_project = described_class.new(name: subject.name, user_id: user.id)
        expect(new_project).not_to be_valid
      end
    end
  end

  # describe "Associations" do
  #   it { should belong_to(:user) }
  #   it { should have_many(:tasks) }
  # end

  # describe "Attributes" do
  #   it { should have_attribute(:time).with_default_value_of(0) }
  # end
end
