require 'twitter'
class User
  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = 'uiqIQUjfeXqqevPzXcaQpapzS'
      config.consumer_secret     = 'QTOoFajZFHyPLvBea7wpxLQBRgftAiyzmI13CYBCumIYYTLnRu'
      config.access_token        = '70911616-o1x7OKq6kDEbAjMC4ZXImUZfpzCgcjm35k35tTety'
      config.access_token_secret = '9nZsqV1Xh4c0W2qbaAayucPNG7kzeJvUZ6wHIVfYRHj6S'
    end
  end
  def timeline count: 20
    client.home_timeline(count: count)
  end
  def lists
    @lists ||= client.owned_lists.map{|l| List.new(l.id, l.name) }
  end
end
