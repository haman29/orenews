class Array
  def summarize
    self.group_by{|i| i}.map{|k,v| [k, v.count] }
  end
  def sort_by_value
    self.sort{|v1, v2| v2[1] <=> v1[1]}
  end
end

class List
  attr_accessor :id, :name, :tweets

  def initialize id, name
    @id = id; @name = name; @tweets = []
  end

  def user
    @user ||= User.new
  end

  def crawl_tweets count: 5, max_id: nil
    return true if count < 0
    params = {count: 200}
    params[:max_id] = max_id if max_id
    _tweets = if id
                user.client.list_timeline(id, params)
              else
                user.timeline(params)
              end
    @tweets += _tweets.map{|_t|
      tweet = Tweet.new(id: _t.id)
      tweet.links = _t.urls.map{|u|
        u.url.to_s
      }
      tweet
    }
    crawl_tweets count: (count -= 1), max_id: @tweets.last.id
  end
end
