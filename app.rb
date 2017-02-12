require 'rubygems'
require 'sinatra'
require 'sinatra/param'
require 'pi_piper'

include PiPiper

set :dump_errors, false
set :environment, :production

PIN2  = PiPiper::Pin.new(:pin => 2, :direction => :out)
PIN3  = PiPiper::Pin.new(:pin => 3, :direction => :out)
PIN4  = PiPiper::Pin.new(:pin => 4, :direction => :out)
PIN17 = PiPiper::Pin.new(:pin => 17, :direction => :out)
PINS  = [ PIN2, PIN3, PIN4, PIN17]

helpers do
  def send_pulse(option)
    pin = PINS[option.to_i - 1]
    pin.on
    sleep 1
    pin.off
  end
end

get '/' do
  redirect '/choose/1'
end

get '/choose/:option' do |option|
  param :option, Integer, required: true, range: 1..4, raise: true
  @option = option
  send_pulse(option)
  erb :home
end
