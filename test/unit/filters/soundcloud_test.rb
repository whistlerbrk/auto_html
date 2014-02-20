# encoding: utf-8
require File.expand_path('../../unit_test_helper', __FILE__)
require 'fakeweb'

class SoundcloudTest < Test::Unit::TestCase
  def test_transform_url_with_www
    result = auto_html('http://www.soundcloud.com/forss/flickermood') { soundcloud }
    assert_equal '<iframe width="100%" height="166" scrolling="no" frameborder="no" src="http://w.soundcloud.com/player/?url=http://www.soundcloud.com/forss/flickermood&show_artwork=false&show_comments=false&auto_play=false&color=915f33&theme_color=00FF00"></iframe>', result
  end

  def test_transform_url_without_www
    result = auto_html('http://soundcloud.com/forss/flickermood') { soundcloud }
    assert_equal '<iframe width="100%" height="166" scrolling="no" frameborder="no" src="http://w.soundcloud.com/player/?url=http://soundcloud.com/forss/flickermood&show_artwork=false&show_comments=false&auto_play=false&color=915f33&theme_color=00FF00"></iframe>', result
  end

  def test_transform_url_without_protocol
    result = auto_html('soundcloud.com/forss/flickermood') { soundcloud }
    assert_equal '<iframe width="100%" height="166" scrolling="no" frameborder="no" src="http://w.soundcloud.com/player/?url=http://soundcloud.com/forss/flickermood&show_artwork=false&show_comments=false&auto_play=false&color=915f33&theme_color=00FF00"></iframe>', result
  end

  def test_transform_url_with_ssl
    result = auto_html('https://soundcloud.com/forss/flickermood') { soundcloud }
    assert_equal '<iframe width="100%" height="166" scrolling="no" frameborder="no" src="http://w.soundcloud.com/player/?url=https://soundcloud.com/forss/flickermood&show_artwork=false&show_comments=false&auto_play=false&color=915f33&theme_color=00FF00"></iframe>', result
  end

  def test_transform_url_with_options
    result = auto_html('http://www.soundcloud.com/forss/flickermood') { soundcloud(:width => '50%', :height => '100', :auto_play => true, :show_comments => true) }    
    assert_equal '<iframe width="50%" height="100" scrolling="no" frameborder="no" src="http://w.soundcloud.com/player/?url=http://www.soundcloud.com/forss/flickermood&show_artwork=false&show_comments=true&auto_play=true&color=915f33&theme_color=00FF00"></iframe>', result
  end

  def test_can_handle_urls_in_html
    txt = %Q{
      http://blog.nu-soulmag.com/wp-content/uploads/2014/02/013-520x245.jpg\n<p>WATCH: Wedding Bells - http://youtu.be/HM04bKL4oq4</p>\n<p>Director - <strong>Peter Marsden</strong> \nProducer - <strong>Christina Kernohan</strong> \nStylist - <strong>Eclair Fifi</strong> \nFull Credits Within Film</p>\n<p>LISTEN: "Wedding Bells" (Zane Lowe BBC Radio 1 debut) - https://soundcloud.com/cashmerecat/wedding_bells</p>\n<p><strong>Cashmere Cat</strong> is the production alias of young Norwegian producer <strong>Magnus August Hoiberg</strong> - who has caught one to watch buzz this year from the single <strong>'With Me'</strong> premiered with <strong>Zane Lowe</strong> on <strong>BBC Radio One</strong> & video premiere at Rolling Stone - plus a feature on the <strong>Ludacris</strong> single "<strong>Party Girls"</strong> alongside <strong>Jeremih & Wiz Khalifa</strong>. An unprecedented mention for a producer, it signals a sea change happening in popular music & the role of our 'underground' producers. With this debut vinyl EP he is truly free - unbeholden to conventional pop structures from vocalists. Cashmere Cat's own songs are crammed full of ingenious melodic ideas and counterpoint. These are songs built in equal parts from glittering RnB, French electro & 00's club Hip Hop - this is wide, cinematic and unabashedly bright new dance music. Rarely does a new artist emerge with such a unique voice across their work - Cashmere Cat is unconcerned with where he fits with DJs and his music is smarter for it.</p>\n<p><em>The Wedding Bells EP</em> represents the next stage for Cashmere Cat as recording artist and has commanded support so far from: <strong>Kode 9, Eclair Fifi, Nguzunguzu, Hud Mo, Rustie, Baauer, Diplo, Skrillex, A Trak, Brodinski</strong> - as well as<strong> BBC Radio One & Triple J.</strong></p>\n<p><strong>LuckyMe</strong> are proud to present: Wedding Bells; Cashmere Cat's attempt at a perfect thing in an imperfect world.</p>\n<p>soundcloud.com/cashmerecat https://twitter.com/CASHMERECAT https://www.facebook.com/cashmerecatofficial‎</p>
    }
    assert_nothing_raised do
      result = auto_html(txt) { soundcloud }
    end
  end

end
