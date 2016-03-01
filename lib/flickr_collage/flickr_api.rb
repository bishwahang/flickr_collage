class FlickrApi
  require "net/http"
  require "json"
  BASE_URI         = "https://api.flickr.com/services/rest/"
  API_KEY          = ENV['FLICKR_API_KEY']
  NO_JSON_CALLBACK = "1"

  def initialize

  end

  def search_tag(tag:,format: "json")
    params = { method: "flickr.photos.search", api_key: API_KEY,tags: "#{tag}", format: format, nojsoncallback: NO_JSON_CALLBACK}
    uri    = URI(BASE_URI)
    uri.query = URI.encode_www_form(params)
    res = JSON.parse(Net::HTTP.get_response(uri).body)
    if res["stat"] == "ok"
      res["photos"]["photo"]
    else
      nil
    end
  end

  def get_photo_ratings(photo_id:,date: nil,format: 'json')
    unless date
      date = Time.now.strftime("%Y-%m-%d")
    end
    params = { method: "flickr.stats.getPhotoStats", api_key: API_KEY, date: "#{date}", photo_id: "#{photo_id}", format: format, nojsoncallback: NO_JSON_CALLBACK}
    uri    = URI(BASE_URI)
    uri.query = URI.encode_www_form(params)
    res = JSON.parse(Net::HTTP.get_response(uri).body)
    if res["stat"] == "ok"
      res
    else
      nil
    end
  end
end
