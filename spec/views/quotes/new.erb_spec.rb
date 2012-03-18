require "spec_helper"

describe "quotes/new" do
  let(:quote) { stub_model(Quote) }
  it "should have a form to send new data" do
    assign(:quote, quote)
    render
    rendered.should have_selector('form')
  end
end
