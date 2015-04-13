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

get '/contacts/:id' do
  if $rolodex.has_contact_with_id?(params[:id].to_i)
    @contact = $rolodex.find_contact(params[:id].to_i)
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

get "/contacts/:id/edit" do
  if $rolodex.has_contact_with_id?(params[:id].to_i)
    @contact = $rolodex.find_contact(params[:id].to_i)
    erb :edit_contact
  else
    puts "something went wrong..."
    raise Sinatra::NotFound
  end
end

get '/contacts/:id/delete' do
  if $rolodex.has_contact_with_id?(params[:id].to_i)
    @contact = $rolodex.find_contact(params[:id].to_i)
    erb :delete_contact
  else
    puts "something went wrong..."
    raise Sinatra::NotFound
  end
end

post '/contacts' do
  $rolodex.add_contact(params[:first_name].capitalize, params[:last_name].capitalize, params[:email], params[:note])
  redirect to('/contacts')
end

put '/contacts/:id' do
  if $rolodex.has_contact_with_id?(params[:id].to_i)
    $rolodex.modify(params[:id].to_i, 1, params[:first_name])
    $rolodex.modify(params[:id].to_i, 2, params[:last_name])
    $rolodex.modify(params[:id].to_i, 3, params[:email])
    $rolodex.modify(params[:id].to_i, 4, params[:note])
    redirect to("/contacts/#{params[:id].to_i}")
  else
    raise Sinatra::NotFound
  end
end

delete '/contacts/:id' do
  if $rolodex.has_contact_with_id?(params[:id].to_i)
    $rolodex.remove_contact(params[:id].to_i)
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end
