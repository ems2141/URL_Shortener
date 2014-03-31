require 'spec_helper'
require 'capybara/rspec'
require_relative '../app'

Capybara.app = App
Capybara.app_host = "http://www.example.com"

feature "URL Shortener shortens URLs" do

  scenario "User can shorten URL and when they visit the new URL, they are redirected to the original" do

    visit '/'

    fill_in('url_input', with: "http://tutorials.gschool.it")
    click_on('Shorten')

    expect(page).to have_content("http://tutorials.gschool.it")
    expect(page).to have_content("http://www.example.com/1")

    #User visits shortened URL and gets redirected to the original URL" do

    visit '/1'
    current_url.should == "http://tutorials.gschool.it/"

    visit '/'
    fill_in('url_input', with: "Non URL")
    click_on('Shorten')

    expect(page).to have_content("The text you entered is not a valid URL")

  end
end