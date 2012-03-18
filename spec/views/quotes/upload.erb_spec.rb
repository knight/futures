require "spec_helper"

describe "quotes/upload" do
  it "should render an upload form with upload button and upload field" do
    render
    rendered.should have_selector('form')
    rendered.should have_selector('input[type=file]')
    rendered.should have_selector('input[type=submit]')
    
  end
end
