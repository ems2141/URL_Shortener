require 'spec_helper'
require 'capybara/rspec'
require_relative '../app'

Capybara.app = App

feature "URL Shortener shortens URLs" do
  scenario "User can see homepage with form" do

    visit '/'

    find_field("Enter the URL you would like to 'shorten'").visible?
    find_button('Shorten').visible?
  end

  scenario "User can shorten URL" do

    visit '/'

    fill_in('url_input', with: "http://tutorials.gschool.it")
    click_on('Shorten')

    expect(page).to have_content("http://tutorials.gschool.it")
    expect(page).to have_content("http://stormy-inlet-1672.herokuapp.com/1")

  end
end