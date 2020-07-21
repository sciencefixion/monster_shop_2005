require 'rails_helper'

RSpec.describe User, type: :model do
    describe "validations" do
        it { should validate_presence_of(:name) }
        it { should validate_presence_of(:address) }
        it { should validate_presence_of(:city) }
        it { should validate_presence_of(:state) }
        it { should validate_presence_of(:zip) }
        it { should validate_presence_of(:email) }
        it { should validate_presence_of(:password) }

        it { should validate_uniqueness_of(:email) }
    end

    describe "roles" do
      it "can create a default user" do
        user = User.create!(name: "Jim", address: "3455 LKV", city: "Hell", state: "MI", email: "test1@test.com", zip: "56765", password: "123456")

        expect(user.role).to eq("default")
        expect(user.default?).to be_truthy

      end
      it "can create a merchant user" do
        user = User.create!(name: "Michael", address: "3455 LKV", city: "Hell", state: "MI", email: "test2@test.com", zip: "56765", password: "123456", role: 1)

        expect(user.role).to eq("merchant")
        expect(user.merchant?).to be_truthy

      end
      it "can create a admin user" do
        user = User.create!(name: "Pam", address: "3455 LKV", city: "Hell", state: "MI", email: "test3@test.com", zip: "56765", password: "123456", role: 2)

        expect(user.role).to eq("admin")
        expect(user.admin?).to be_truthy

      end
    end

end
