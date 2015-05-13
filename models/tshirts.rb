require_relative '../lib/connection'

class Shirt < ActiveRecord::Base
  has_many :orders
end