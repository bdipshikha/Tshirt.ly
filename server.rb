require 'sinatra'
require 'active_record'
require_relative 'models/tshirts'

get '/admin' do
    shirts = Shirt.all
    erb :admin, locals: {shirts: shirts}
end

get '/' do 
    redirect '/shirts'
end

get '/shirts' do 
    shirts = Shirt.all
    erb :index, locals: {shirts: shirts}
end

get '/shirts/new' do
    erb :new
end

get '/shirts/:id/edit' do
    shirt = Shirt.find(params[:id])
    erb :edit, locals: {item: item}
end


post '/shirts' do 
    style = params[:style]
    color = params[:color]
    price = params[:price]
    instock = params[:instock]
    shirt_image = params[:shirt_image]
    
    Shirt.create({style: style, color: color, price: price, instock: instock, shirt_image: shirt_image})
    
    redirect('/admin')
end

put '/shirts/:id' do 
    shirt = Shirt.find(params[:id])
    
    style = params[:style]
    color = params[:color]
    price = params[:price]
    shirt_image = params[:shirt_image]
    
    shirt.update({style: style, color: color, price: price, shirt_image: shirt_image})
    
    redirect('/admin')
end
        
delete '/shirts/:id' do 
    shirt = Shirt.find(params[:id])
    shirt.destroy
    redirect('/shirts')
end

