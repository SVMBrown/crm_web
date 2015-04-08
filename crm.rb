require_relative 'contact'
require 'sinatra'
get '/' do
  @crm_app_name = "My CRM"
  erb :index
end

get '/contacts' do
  @contacts = []
  @contacts << Contact.new("Scot", "Brown", "sb@sb.com", "me")
  @contacts << Contact.new("Cody", "Brown", "cb@cb.com", "bro")
  @contacts << Contact.new("Chelsea", "Brown", "cb@cb.net", "Sis")
  @contacts << Contact.new("Debi", "Brown", "db@db.net", "Mom")
  @contacts << Contact.new("Dennis", "Brown", "db@db.com", "Dad")

  erb :view_contacts
end

get '/contacts/new' do
  "New Contact"
end
