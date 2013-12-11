# encoding: UTF-8
require 'uri'

# set these options and default values
# :width => '100%', :height => 166, :auto_play => false, :theme_color => '00FF00', :color => '915f33', :show_comments => false
AutoHtml.add_filter(:soundcloud).with(:width => '100%', :height => 166, :auto_play => false, :theme_color => '00FF00', :color => '915f33', :show_comments => false, :show_artwork => false) do |text, options|
  text.gsub(/(https?:\/\/)?(www.)?soundcloud\.com\/\S*/) do |match|
    new_uri = match.to_s
    new_uri = (new_uri =~ /^https?\:\/\/.*/) ? URI(new_uri) : URI("http://#{new_uri}")
    new_uri.normalize!

    uri = URI("http://soundcloud.com/oembed")
    params = {:format => 'json', :url => new_uri}.merge(options)
    uri.query = params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&')
    response = Net::HTTP.get(uri)
    if !response.blank?
      JSON.parse(response)["html"]
    else
      match
    end
  end
end

