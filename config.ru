ApplicationServer = Rack::Builder.new do
  map "/" do
    run Api::Root
  end
end

run ApplicationServer
