require 'sinatra'
require_relative './spread_driver.rb'
set :environment, :production

get '/' do
  # html/index.html
  File.read(File.join('public/html', 'index.html'))
end

get '/:sheet' do
  sheet = params[:sheet]
  driver = SpreadDriver.new(sheet)

  data = driver.get_by_sheet(sheet)

  data.to_json
end

get '/:sheet/row/:row/column/:column' do
  sheet = params[:sheet]
  row = params[:row]
  column = params[:column]

  redirect '/404/invalid_row' if row.to_i == 1 # 1行目は論理名のため

  content_type :json
  driver = SpreadDriver.new(sheet)
  data = driver.get_by_row_and_column(params[:row], params[:column])
  data.to_json
end

get '/404/:reason' do
  content_type :json
  status 404
  {error: "#{params[:reason].to_s}"}.to_json
end

post '/:sheet/create' do
  body = request.body.read
  return status 400 if body.empty?

  data = JSON.parse body

  sheet = params[:sheet]

  driver = SpreadDriver.new(sheet)
  driver.create(data)
  status 201
end
