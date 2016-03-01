class Collage
  require 'net/http'
  require 'fileutils'
  require 'open-uri'
  require 'tempfile'
  require 'rmagick'
  include Magick

  require 'pry'


  PHOTO_URI = "https://farm%{farm}.staticflickr.com/%{server}/%{id}_%{secret}_m.jpg"
  TOTAL_IMAGE_COUNT = 10

  COLUMNS = 5
  ROWS    = 2

  WIDTH  = 1024
  HEIGHT = 768

  attr_accessor :photos, :api, :options, :temp_dir

  def initialize(opts = {})
    default_options = {tags: [],
                       output: "/tmp/test_output.png",
                       temp_dir: "/tmp/photos/",
                       # temp_dir: File.expand_path("../../../temp", __FILE__),
                       verbose:false}

    @options = default_options.merge(opts)
    @api     = FlickrApi.new
    @photos = []
    @verbose = options.fetch(:verbose,false)
    FileUtils::mkdir_p(options[:temp_dir]) unless File.exists?(options[:temp_dir])
    puts "Initialized" if options[:verbose]
  end

  def get_collage
    options[:tags].each do |tag|
      get_photos_by_tag(tag)
    end

    puts "Total photos from given tags: #{photos.count}" if options[:verbose]
    while photos.count < TOTAL_IMAGE_COUNT do
      difference = TOTAL_IMAGE_COUNT - photos.count
      random_tags = get_random_tags(difference)
      puts "Random tags from dictionary: #{random_tags.inspect}" if options[:verbose]
      random_tags.each do |tag|
        get_photos_by_tag(tag)
      end
    end
    create_collage
    teardown
  end

  private

  def get_photos_by_tag(tag)
    puts "getting photos for tag #{tag}" if options[:verbose]
    image_urls = []
    photos_json = api.search_tag(tag: tag)
    photos_json.each do |photo|
      photo = photo.reduce({}) do |memo, (k, v)|
          memo.merge({ k.to_sym => v })
      end
       image_urls << generate_photo_uri(photo)
    end
    url = image_urls.sample(1)[0]
    temp_image = save_url(url, tag)
    if temp_image
      puts "Photo found for tag #{tag}" if options[:verbose]
      photos << Photo.new(url, temp_image)
    end
  end

  def save_url(url,tag)
    puts "Saving photos for tag #{tag}" if options[:verbose]
    begin
      uri = URI.parse(url)
      file = open(File.join(options[:temp_dir],"#{tag}.jpg"),"wb")
      file.binmode
      file << open(uri).read
    rescue Exception => e
      if options[:verbose]
        puts e.message
        puts e.backtrace.inspect
      end
      return nil
    else
      puts "#{File.basename(file)} file created for tag #{tag}" if options[:verbose]
      return File.absolute_path(file)
    ensure
      file.close if file
    end
  end

  def generate_photo_uri(photo)
    PHOTO_URI % photo
  end

  def get_random_tags(count)
    @dictionary ||= File.read("/usr/share/dict/words").split("\n")
    @dictionary.sample(count)
  end

  def create_collage
    image_list = ImageList.new
    photos.each do |p|
      image = Image.read(p.path).first
      image.border!(10, 10, "#ffffff")
      image.background_color = "none"
      image.crop(NorthWestGravity,40,90)
      image_list << image
    end
    image_list.montage do |mont|
      mont.title            = "Coolest Collection Collage"
      mont.tile             = Geometry.new(COLUMNS,ROWS)
      mont.background_color = 'white'
      mont.gravity          = NorthWestGravity
      mont.shadow           = true
    end.write options[:output]
  end

  def teardown
    begin
      FileUtils.rm_rf(options[:temp_dir])
    rescue Exception => e
      if options[:verbose]
        puts e.message
        puts e.backtrace.inspect
      end
        puts e.message
        puts e.backtrace.inspect
    else
      puts "Temp directory removed succesfully" if options[:verbose]
    end
  end


  class Photo
    attr_accessor :url, :path
    def initialize(photo_url, temp_path)
      @url  = photo_url
      @path = temp_path
    end
  end
  private_constant :Photo

end
