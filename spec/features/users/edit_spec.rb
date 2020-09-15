require "rails_helper"

RSpec.describe "User show page", type: :feature do
  describe "As a user" do
    it "I can Edit my Info" do
      user = User.create(email: "funbucket13@gmail.com",
                        password: "test",
                        name: "Mike Dao",
                        street_address: "123 easy street",
                        city: "Anycity",
                        state: "Anystate",
                        zip: 12345,
                        role: 0)

      visit '/'

      click_on "Login"

      expect(current_path).to eq("/login")

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on "Login to Account"
      expect(current_path).to eq("/profile")
      expect(page).to have_content("#{user.name}")
      expect(page).to have_content("#{user.street_address}")
      expect(page).to have_content("#{user.city}")
      expect(page).to have_content("#{user.state}")
      expect(page).to have_content("#{user.zip}")
      expect(page).to have_content("#{user.email}")
      expect(page).to have_link("Edit My Info")

      click_link "Edit My Info"

      expect(current_path).to eq("/profile/edit")

      expect(page).to have_field(:name, :with => user.name)
      expect(page).to have_field(:street_address, :with => user.street_address)
      expect(page).to have_field(:city, :with => user.city)
      expect(page).to have_field(:state, :with => user.state)
      expect(page).to have_field(:zip, :with => user.zip)
      expect(page).to have_field(:email, :with => user.email)
      expect(page).to_not have_field(:password)

      fill_in :name, with: "Captain Jack"
      fill_in :street_address, with: "123 Main Street"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: "11111"
      fill_in :email, with: "c_j@email.com"

      click_on "Submit Changes"
      user = User.create(email: "c_j@email.com",
                        password: "test",
                        name: "Captain Jack",
                        street_address: "123 Main Street",
                        city: "Denver",
                        state: "CO",
                        zip: 11111,
                        role: 0)

      expect(current_path).to eq("/profile")
      expect(page).to have_content("Successfully updated your information!")

      expect(page).to have_content("#{user.name}")
      expect(page).to have_content("#{user.street_address}")
      expect(page).to have_content("#{user.city}")
      expect(page).to have_content("#{user.state}")
      expect(page).to have_content("#{user.zip}")
      expect(page).to have_content("#{user.email}")
    end

    it "I can't leave fields blank" do
      user = User.create(email: "funbucket13@gmail.com",
                        password: "test",
                        name: "Mike Dao",
                        street_address: "123 easy street",
                        city: "Anycity",
                        state: "Anystate",
                        zip: 12345,
                        role: 0)

      visit '/'

      click_on "Login"

      expect(current_path).to eq("/login")

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on "Login to Account"
      expect(current_path).to eq("/profile")
      expect(page).to have_content("#{user.name}")
      expect(page).to have_content("#{user.street_address}")
      expect(page).to have_content("#{user.city}")
      expect(page).to have_content("#{user.state}")
      expect(page).to have_content("#{user.zip}")
      expect(page).to have_content("#{user.email}")
      expect(page).to have_link("Edit My Info")

      click_link "Edit My Info"

      expect(current_path).to eq("/profile/edit")

      expect(page).to have_field(:name, :with => user.name)
      expect(page).to have_field(:street_address, :with => user.street_address)
      expect(page).to have_field(:city, :with => user.city)
      expect(page).to have_field(:state, :with => user.state)
      expect(page).to have_field(:zip, :with => user.zip)
      expect(page).to have_field(:email, :with => user.email)
      expect(page).to_not have_field(:password)

      fill_in :name, with: ""
      fill_in :street_address, with: "123 Main Street"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: "11111"
      fill_in :email, with: "c_j@email.com"

      click_on "Submit Changes"

      expect(current_path).to eq("/profile/edit")
      expect(page).to have_content("Please fill in all fields.")
    end

    describe "User show page", type: :feature do
      describe "As a user" do
        it "I can Edit my Password" do
          user = User.create(email: "funbucket13@gmail.com",
                            password: "test",
                            name: "Mike Dao",
                            street_address: "123 easy street",
                            city: "Anycity",
                            state: "Anystate",
                            zip: 12345,
                            role: 0)
          visit '/'
          click_on "Login"

          fill_in :email, with: user.email
          fill_in :password, with: user.password

          click_on "Login to Account"

          expect(current_path).to eq("/profile")
          expect(page).to have_content("#{user.name}")
          expect(page).to have_content("#{user.street_address}")
          expect(page).to have_content("#{user.city}")
          expect(page).to have_content("#{user.state}")
          expect(page).to have_content("#{user.zip}")
          expect(page).to have_content("#{user.email}")
          expect(page).to have_link("Edit My Password")

          click_link "Edit My Password"

          expect(current_path).to eq("/profile/password")


          expect(page).to have_field(:password)
          expect(page).to have_field(:password_confirmation)

          fill_in :password, with: "test2"
          fill_in :password_confirmation, with: "test2"

          click_on "Save Password"

          expect(current_path).to eq("/profile")
          expect(page).to have_content("Successfully updated your password!")
        end

        it "I can't have mismatching passwords" do

          user = User.create(email: "funbucket13@gmail.com",
                            password: "test",
                            name: "Mike Dao",
                            street_address: "123 easy street",
                            city: "Anycity",
                            state: "Anystate",
                            zip: 12345,
                            role: 0)
          visit '/'
          click_on "Login"

          fill_in :email, with: user.email
          fill_in :password, with: user.password

          click_on "Login to Account"

          expect(current_path).to eq("/profile")
          expect(page).to have_content("#{user.name}")
          expect(page).to have_content("#{user.street_address}")
          expect(page).to have_content("#{user.city}")
          expect(page).to have_content("#{user.state}")
          expect(page).to have_content("#{user.zip}")
          expect(page).to have_content("#{user.email}")
          expect(page).to have_link("Edit My Password")

          click_link "Edit My Password"

          expect(current_path).to eq("/profile/password")


          expect(page).to have_field(:password)
          expect(page).to have_field(:password_confirmation)

          fill_in :password, with: "test2"
          fill_in :password_confirmation, with: "test3"

          click_on "Save Password"

          expect(current_path).to eq("/profile/password")
          expect(page).to have_content("Please have matching fields before submission.")
        end
      end

      it "User Editing Profile Data must have unique Email address" do
        user = User.create(email: "funbucket13@gmail.com",
                          password: "test",
                          name: "Mike Dao",
                          street_address: "123 easy street",
                          city: "Anycity",
                          state: "Anystate",
                          zip: 12345,
                          role: 0)
        user2 = User.create(email: "funbucket12@gmail.com",
                          password: "test123",
                          name: "Mike Do",
                          street_address: "1222 ez street",
                          city: "Anycity",
                          state: "Anystate",
                          zip: 12345,
                          role: 0)

        visit '/'
        click_on "Login"

        fill_in :email, with: user.email
        fill_in :password, with: user.password

        click_on "Login to Account"
        visit "/profile"

        click_link "Edit My Info"


        fill_in :name, with: user.name
        fill_in :street_address, with: user.street_address
        fill_in :city, with: user.city
        fill_in :state, with: user.state
        fill_in :zip, with: user.zip
        fill_in :email, with: user2.email

        click_on "Submit Changes"

        expect(current_path).to eq("/profile/edit")
        expect(page).to have_content("This email is already in use! Please try again!!")
      end
    end
  end
end
