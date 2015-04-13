require 'sinatra'
require 'data_mapper'


DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
  include DataMapper::Resource

  property :id, Serial
  property :first_name, String
  property :last_name, String
  property :email, String
  property :note, String
end

DataMapper.finalize
DataMapper.auto_upgrade!

get '/' do
  @crm_app_name = "My CRM"
  erb :index
end

get '/contacts' do
  @contacts = Contact.all
  erb :view_contacts
end

get '/contacts/new' do
  erb :add_new_contact
end

get '/contacts/:id' do
  @contact = Contact.get(params[:id])
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

get "/contacts/:id/edit" do
  @contact = Contact.get(params[:id])
  if @contact
    erb :edit_contact
  else
    puts "something went wrong..."
    raise Sinatra::NotFound
  end
end

get '/contacts/:id/delete' do
  @contact = Contact.get(params[:id])
  if @contact
    erb :delete_contact
  else
    puts "something went wrong..."
    raise Sinatra::NotFound
  end
end

post '/contacts' do
  Contact.create(
    first_name: params[:first_name].capitalize,
    last_name: params[:last_name].capitalize,
    email: params[:email],
    note: params[:note]
  )
  redirect to('/contacts')
end

put '/contacts/:id' do
  @contact = Contact.get(params[:id])
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name =  params[:last_name]
    @contact.email =  params[:email]
    @contact.note =  params[:note]
    @contact.save
    redirect to("/contacts/#{params[:id]}")
  else
    raise Sinatra::NotFound
  end
end

delete '/contacts/:id' do
  @contact = Contact.get(params[:id])
  if @contact
    @contact.destroy
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end
