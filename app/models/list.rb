class Array
  def summarize
    self.group_by{|i| i}.map{|k,v| [k, v.count] }.to_h
  end
end
class List
  attr_accessor :id, :name

  def initialize id, name
    @id = id; @name = name
  end

  def user
    @user ||= User.new
  end

  def timeline
    tweets = if id
               user.client.list_timeline(id, count: 200)
             else
               user.timeline(count: 200)
             end
    @links ||= tweets.map{|t|
      t.urls.map{|u|
        u.url.to_s
      }
    }.flatten
  end
end
