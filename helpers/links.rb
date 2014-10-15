def link(display, url)
  "<a href='#{url}'>#{display}</a>"
end

def relativize url
  uri = URI.parse(url)
  if uri.host == data.site.domain
    uri.route_from "http://#{data.site.domain}"
  else
    uri
  end
end
