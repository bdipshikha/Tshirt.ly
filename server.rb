require 'sinatra'
require 'active_record'
require 'pry'
require_relative 'models/tshirts'
require_relative 'models/orders'

get '/orders' do
    
    shirts = Shirt.joins(:orders)
    orders = Order.all
    erb :orders, locals: {orders: orders, shirts: shirts} 
end

post '/orders/:id' do
    id =  params[:id]
    qty = params[:qty]
    puts qty

    shirt = Shirt.find(id)
   
    new_instock = shirt.instock - qty
    Shirt.update({instock: new_instock}) 
    redirect("/shirts")
end

get '/admin' do
    shirts = Shirt.all
    erb :admin, locals: {shirts: shirts}
end

get '/' do 
    redirect '/shirts'
end

get '/receipt/:id' do
    erb :receipt
end

get '/shirts' do 
    shirts = Shirt.all
    erb :index, locals: {shirts: shirts}
end

get '/shirts/:id' do
    id = params[:id]
    indv_shirt = Shirt.find(id)
    erb :show, locals: {shirt: indv_shirt}
end

get '/shirts/new' do
    erb :new
end

get '/shirts/:id/edit' do
    shirt = Shirt.find(params[:id])
    erb :edit, locals: {item: item}
end

post '/orders' do
    # id INTEGER PRIMARY KEY,
    # email TEXT,
    # shirt_id INTEGER,
    # quantity INTEGER,
    # status TEXT,
    # created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

    order = Order.create({email: params[:email], shirt_id: params[:shirt_id], quantity: params[:qty]});
    redirect "/receipt/#{order.id}"
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
    
    price = params[:price]
    instock = params[:instock]
    
    shirt_image = params[:shirt_image]
    
    shirt.update({price: price, shirt_image: shirt_image, instock: instock})
    
    redirect('/admin')
end
        
delete '/shirts/:id' do 
    shirt = Shirt.find(params[:id])
    shirt.destroy
    redirect('/admin')
end

