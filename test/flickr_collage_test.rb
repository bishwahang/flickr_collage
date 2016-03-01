require 'test_helper'

class FlickrCollageTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::FlickrCollage::VERSION
  end
end
