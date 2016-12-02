class CookieMiddleware < Midori::Middleware
  def before(request)
    unless request.header['Cookie'].nil?
      raw_cookie = request.header['Cookie'].clone
      request.header['Cookie'] = Hash.new
      raw_cookie.split('; ').map do |item|
        pair = item.split('=')
        request.header['Cookie'][pair[0]] = pair[1]
      end
    end
    request
  end

  def after(_request, response)
    response
  end

  helper :get_cookie do |key|
    request.header['Cookie'][key]
  end
end