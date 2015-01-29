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

  def all_registers website
    website.registers.count
  end

  def influential_registers website
    website.registers.where(:is_influential => true).all.count
  end

end
