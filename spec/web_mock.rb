require 'webmock/rspec'
require 'spec_helper'

class MockeadorEndpoints
  def mockear_endpoint(endpoint, status, body)
    WebMock.stub_request(:post, "#{ENV['URL_BASE'] || 'http://localhost:3000'}#{endpoint}")
           .with(headers: { 'Content-Type' => 'application/json' })
           .to_return(status: status, body: body.to_json)
  end

  def mockear_get(endpoint, status, body)
    WebMock.stub_request(:get, "#{ENV['URL_BASE'] || 'http://localhost:3000'}#{endpoint}")
           .with(headers: { 'Content-Type' => 'application/json' })
           .to_return(status: status, body: body.to_json)
  end
end
