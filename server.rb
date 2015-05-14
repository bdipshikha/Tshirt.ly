require 'sinatra'
require 'active_record'
require 'pry'
require 'cgi'
require_relative 'models/tshirts'
require_relative 'models/orders'

post '/cancel_order' do
    order = Order.find(params[:order_id].to_i)
    shirt = Shirt.find(params[:shirt_id].to_i)


    qty = shirt.instock + params[:quantity].to_i
    shirt.update({instock: qty})
    
    order.destroy
    redirect('/admin')
end

put '/shipped_order' do 
    order = Order.find(params[:order_id].to_i)
    status = "shipped"
    order.update({status: status})
    redirect("/orders")
end


get '/orders' do
    shirts = Shirt.joins(:orders)
    orders = Order.all
    erb :orders, locals: {orders: orders, shirts: shirts}
end

get '/admin' do
    shirts = Shirt.all.order(:style).order(:color)
    erb :admin, locals: {shirts: shirts}
end

get '/' do
    redirect '/shirts'
end


get '/receipt/:order_id' do
    shirt = Shirt.joins(:orders).where('orders.id' => params[:order_id])[0]
    order = Order.find(params[:order_id])
    erb :receipt, locals: {shirt: shirt, order: order}
end

get '/shirts' do 

    shirts = Shirt.group(:style)
    # shirts = Shirt.all
    erb :index, locals: {shirts: shirts}
end

get '/shirts/:style' do
    style = CGI.unescape(params[:style])
    shirts = Shirt.where(style: style)
    # id = params[:id]
    # indv_shirt = Shirt.find(id)
    erb :show, locals: {shirts: shirts}
end

get '/shirts/new' do
    erb :new
end

get '/shirts/:id/edit' do
    shirt = Shirt.find(params[:id])
    erb :edit, locals: {item: item}
end

post '/orders' do
    id = params[:shirt_id].to_i
    qty = params[:qty].to_i

    shirt = Shirt.find(id)

    new_instock = shirt.instock.to_i - qty
    shirt.update({instock: new_instock})

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
