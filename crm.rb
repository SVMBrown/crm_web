require_relative 'rolodex'
require 'sinatra'
$rolodex = Rolodex.new
get '/' do
  @crm_app_name = "My CRM"
  erb :index
end

get '/contacts' do
  erb :view_contacts
end

get '/contacts/new' do
  erb :add_new_contact
end

post '/contacts' do
  $rolodex.add_contact(params[:first_name].capitalize, params[:last_name].capitalize, params[:email], params[:note])
  redirect to('/contacts')
end
