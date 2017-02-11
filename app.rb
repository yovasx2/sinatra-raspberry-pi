require 'rubygems'
require 'sinatra'
require 'sinatra/param'
require 'pi_piper'

include PiPiper

helpers do
  def send_pulse(pin)
    pin = PiPiper::Pin.new(:pin => pin, :direction => :out)
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
