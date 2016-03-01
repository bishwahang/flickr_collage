require "flickr_collage/version"
require "flickr_collage/flickr_api"
require "flickr_collage/collage"

module FlickrCollage
  # Command Line
  def self.run(options)
    Collage.new(options).get_collage()
  end
end
