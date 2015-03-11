require File.expand_path('../../unit_test_helper', __FILE__)

class YouTubeTest < Minitest::Test

  DIV_START = '<div class="video-container youtube">'

  def test_transform
    result = auto_html('http://www.youtube.com/watch?v=BwNrmYRiX_o') { youtube }
    assert_equal %Q|#{DIV_START}<iframe width="420" height="315" src="//www.youtube.com/embed/BwNrmYRiX_o" frameborder="0" allowfullscreen></iframe></div>|, result
  end

  def test_transform_2
    result = auto_html('http://www.youtube.com/watch?v=BwNrmYRiX_o&eurl=http%3A%2F%2Fvukajlija.com%2Fvideo%2Fklipovi%3Fstrana%3D6&feature=player_embedded') { youtube }
    assert_equal %Q|#{DIV_START}<iframe width="420" height="315" src="//www.youtube.com/embed/BwNrmYRiX_o" frameborder="0" allowfullscreen></iframe></div>|, result
  end

  def test_transform_3
    result = auto_html('http://www.youtube.com/watch?v=BwNrmYRiX_o&feature=related') { youtube }
    assert_equal %Q|#{DIV_START}<iframe width="420" height="315" src="//www.youtube.com/embed/BwNrmYRiX_o" frameborder="0" allowfullscreen></iframe></div>|, result
  end

  def test_transform_with_foo
    result = auto_html('foo http://www.youtube.com/watch?v=fT1ahr81HLw bar') { youtube }
    assert_equal %Q|foo #{DIV_START}<iframe width="420" height="315" src="//www.youtube.com/embed/fT1ahr81HLw" frameborder="0" allowfullscreen></iframe></div> bar|, result
  end

  def test_transform_with_foo_bar_break
    result = auto_html('foo http://www.youtube.com/watch?v=fT1ahr81HLw<br>bar') { youtube }
    assert_equal %Q|foo #{DIV_START}<iframe width="420" height="315" src="//www.youtube.com/embed/fT1ahr81HLw" frameborder="0" allowfullscreen></iframe></div><br>bar|, result
  end

  def test_transform_url_without_www
    result = auto_html('http://youtube.com/watch?v=BwNrmYRiX_o') { youtube }
    assert_equal %Q|#{DIV_START}<iframe width="420" height="315" src="//www.youtube.com/embed/BwNrmYRiX_o" frameborder="0" allowfullscreen></iframe></div>|, result
  end

  def test_transform_with_options
    result = auto_html('http://www.youtube.com/watch?v=BwNrmYRiX_o') { youtube(:width => 300, :height => 255, :frameborder => 1, :wmode => 'window') }
    assert_equal %Q|#{DIV_START}<iframe width="300" height="255" src="//www.youtube.com/embed/BwNrmYRiX_o?wmode=window" frameborder="1" allowfullscreen></iframe></div>|, result
  end

  def test_transform_with_short_url
    result = auto_html('http://www.youtu.be/BwNrmYRiX_o') { youtube }
    assert_equal %Q|#{DIV_START}<iframe width="420" height="315" src="//www.youtube.com/embed/BwNrmYRiX_o" frameborder="0" allowfullscreen></iframe></div>|, result
  end

  def test_transform_https
    result = auto_html("https://www.youtube.com/watch?v=t7NdBIA4zJg") { youtube }
    assert_equal %Q|#{DIV_START}<iframe width="420" height="315" src="//www.youtube.com/embed/t7NdBIA4zJg" frameborder="0" allowfullscreen></iframe></div>|, result
  end

  def test_short_with_params
    result = auto_html("http://youtu.be/t7NdBIA4zJg?t=1s&hd=1") { youtube }
    assert_equal %Q|#{DIV_START}<iframe width="420" height="315" src="//www.youtube.com/embed/t7NdBIA4zJg" frameborder="0" allowfullscreen></iframe></div>|, result
  end

  def test_transform_without_protocol
    result = auto_html("www.youtube.com/watch?v=t7NdBIA4zJg") { youtube }
    assert_equal %Q|#{DIV_START}<iframe width="420" height="315" src="//www.youtube.com/embed/t7NdBIA4zJg" frameborder="0" allowfullscreen></iframe></div>|, result
  end

  def test_prevent_html_transform
    str = '<div class="video youtube"><iframe width="420" height="315" src="//www.youtube.com/embed/t7NdBIA4zJg" frameborder="0" allowfullscreen></iframe></div>'

    result = auto_html(str) { youtube }

    assert_equal(
      str, result, 
      "Should not re-transform HTML with YouTube links inside of it"
    )
  end

  def test_prevent_html_transform_in_link
    str = %Q\
     With its piano line highly reminiscent of Journey's "<a href="https://www.youtube.com/watch?v=OMD8hBsA-RI#t=221">Faithfully</a>," One Direction's "Steal My Girl"
    \
    result = auto_html(str) { youtube }
    assert_equal(
      str, result, 
      "Should not re-transform HTML with YouTube links inside of it"
    )
  end

end
