require_relative '../lib/connection'

class Order < ActiveRecord::Base
  belongs_to :shirt
end