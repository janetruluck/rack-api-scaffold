require File.expand_path('../config/environment', __FILE__)

ApplicationServer = Rack::Builder.new do
  map "/" do
    run Api::Root
  end
end

run ApplicationServer
