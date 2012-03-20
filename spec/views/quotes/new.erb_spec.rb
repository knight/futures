require "spec_helper"

describe "quotes/new" do
  context "quote creation" do
  let(:quote) { stub_model(Quote).as_new_record }
  it "should have a form to send new data" do
    assign(:quote, quote)
    render
    rendered.should have_selector('form[action="/quotes"][method="post"]')
   
  end
  end
  context "quote edition" do
    let(:quote) { stub_model(Quote, {:id=>1}) }
    it "can be used for quote editing" do
      assign(:quote, quote)
      render
      rendered.should have_selector('form[action="/quotes/1"]') do |f|
        f.should have_selector('input[type="hidden"][value="put"]')
      end
    end
  end
end
