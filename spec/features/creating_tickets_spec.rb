require "rails_helper"


RSpec.feature "Users can create new tickets" do
  let(:user) {FactoryBot.create(:user)}
  # a_different_user = FactoryBot.create(:user, email: "test4@example.com")
  # FactoryBot.create(:ticket, author: a_different_user)

  before do
    login_as(user)
    project = FactoryBot.create(:project, name: "Internet Explorer")

    visit project_path(project)
    click_link "New Ticket"
  end
    # login_as(FactoryBot.create(:user, :admin))

  scenario "with valid attributes" do
    fill_in "Name", with: "Non-standards compliance"
    fill_in "Description", with: "My pages are ugly!"
    click_button "Create Ticket"

    expect(page).to have_content "Ticket has been created."
    within(".ticket") do
      expect(page).to have_content "Author: #{user.email}"
    end
  end

  scenario "when providing invalid attributes" do
    click_button "Create Ticket"

    expect(page).to have_content "Ticket has not been created."
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Description can't be blank"
  end

  scenario "with an invalid description" do
    fill_in "Name", with: "Non-standards compliance"
    fill_in "Description", with: "It sucks"
    click_button "Create Ticket"

    expect(page).to have_content "Ticket has not been created."
    expect(page).to have_content "Description is too short"
  end

  # scenario "with an attachment" do
  #   fill_in "Name", with: "Add documentation for blink tag"
  #   fill_in "Description", with: "The blink tag has a speed attribute"
  #   attach_file "File", "spec/fixtures/speed.txt"
  #   click_button "Create Ticket"

  #   expect(page).to have_content "Ticket has been created."

  #   within(".ticket .attachment") do
  #     expect(page).to have_content "speed.txt"
  #   end
  # end

  xit "with multiple attachments", js: true do
    fill_in "Name", with: "Add documentation for blink tag"
    fill_in "Description", with: "The blink tag has a speed attribute"

    attach_file("spec/fixtures/gradient.txt", class: 'dz-hidden-input', visible: false)
    attach_file("spec/fixtures/speed.txt", class: 'dz-hidden-input', visible: false)
    attach_file("spec/fixtures/spin.txt", class: 'dz-hidden-input', visible: false)

    click_button "Create Ticket"

    expect(page).to have_content "Ticket has been created."

    within(".ticket .attachments") do
      expect(page).to have_content "speed.txt"
      expect(page).to have_content "spin.txt"
      expect(page).to have_content "gradient.txt"
    end
  end
end