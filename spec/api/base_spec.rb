require "spec_helper"

describe Api::Root do
  it "should rescue from non existent route" do
    get "/this/path/does/not/exist"
    expect(last_response.content_type).to eq('application/json')
    expect(last_response.status).to eq(404)
    expect(last_response.body).to eq({'error' => "404 Not Found"}.to_json)
  end
end
