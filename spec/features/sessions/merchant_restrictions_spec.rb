require "rails_helper"

RSpec.describe "merchant restrictions", type: :feature do

    it "merchant cannot use admin routes" do
        user = User.create(name: "Jim", address: "3455 LKV", city: "Hell", state: "MI", email: "test@test.com", zip: "56765", password: "123456", role: 1)
        allow_any_instance_of(ApplicationController).to receive(:user_session).and_return(user.id)
        
        visit "/admin"

        expect(page).to  have_content("Forbidden to access this route.")
        visit "/admin/users"
        expect(page).to  have_content("Forbidden to access this route.")
    end
end
