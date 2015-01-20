module WebsitesHelper

  def check_url fullurl
    if !!URI.parse(fullurl)
      uri = URI.parse(fullurl)
      if uri.kind_of?(URI::HTTP) or uri.kind_of?(URI::HTTPS)
        uri.host
      else
        uri.path
      end
    else
      return
    end
  end
end
