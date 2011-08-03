require 'rubygems'
require 'sinatra'
require 'json'

require File.expand_path(File.dirname(__FILE__) + "/../lib/ve")

get '/:language/:function' do
  run
end

post '/:language/:function' do
  run
end

private

def run
#  Ve.source = Ve::Local # Default
#  Ve.source = Ve::Remote.new(:url => 'http://ve.kimtaro.com/', :access_token => 'XYZ')
#  result = Ve.get(params[:text], params[:language], params[:function].to_sym)
  result = Ve.in(params[:language]).words(params[:text])

  case params[:function].to_sym
  when :words
    json = JSON.generate(result.collect(&:as_json))
  else
    json = result
  end

  if params[:callback]
    json = "#{params[:callback]}(#{json})"
  end

  json
end