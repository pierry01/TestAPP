require 'httparty'
require 'factory_bot_rails'

describe 'HTTParty' do
  # it 'content_type', vcr: { cassette_name: 'jsonplaceholder/posts', match_requests_on: [:body] } do
  it 'content_type', vcr: { cassette_name: 'jsonplaceholder/posts', record: :new_episodes } do
    # stub_request(:get, "https://jsonplaceholder.typicode.com/posts/2").
    #   to_return(
    #     status: 200, 
    #     headers: { 'content-type':'application/json' }
    #   )
         
    # VCR.use_cassette('jsonplaceholder/posts') do      //  :vcr
    response = HTTParty.get("https://jsonplaceholder.typicode.com/posts/2")
    content_type = response.headers['content-type']
    expect(content_type).to match(/application\/json/)
  end
end