%w(base filter builder).each do |f|
  require File.expand_path("../auto_html/#{f}", __FILE__)
end

Dir["#{File.dirname(__FILE__) + '/auto_html/filters'}/**/*"].each do |filter|
  require "#{filter}"
end

# if rails
require 'auto_html/railtie' if defined?(Rails::Railtie)
if defined?(ActiveRecord::Base)
  require 'auto_html/auto_html_for'
  ActiveRecord::Base.send :include, AutoHtmlFor

  module ActionView::Helpers::TextHelper
    include AutoHtml
  end
end