require 'sinatra'
require 'active_record'
require_relative 'models/tshirts'

get '/admin' do
    shirt = Shirt.all
    erb :index, locals: {shirt: shirt}
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
    shirt_image = params[:image]
    
    Shirt.create({style: style, color: color, price: price, shirt_image: image})
    
    redirect('/shirts')
end

put '/shirts/:id' do 
    shirt = Shirt.find(params[:id])
    
    style = params[:style]
    color = params[:color]
    price = params[:price]
    shirt_image = params[:image]
    
    shirt.update({style: style, color: color, price: price, shirt_image: image})
    
    redirect('/shirts')
end
        
        delete '/shirts/:id' do 
            shirt = Shirt.find(params[:id])
            shirt.destroy
            redirect('/shirts')
        end

