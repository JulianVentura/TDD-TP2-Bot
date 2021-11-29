require 'webmock/rspec'

RSpec.configure do |config|
  config.before(:each) do
    stub_request(:post, 'http://localhost:3000/usuarios')
      .with(headers: { 'Content-Type' => 'application/json' })
      .to_return(status: 201, body: { nombre: 'juan', email: 'juan@mail.com', id: 123 }.to_json)
  end
end
