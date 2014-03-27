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
end