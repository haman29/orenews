class Link
  attr_accessor :link
  def initialize link
    @link = link
  end
  def user
    @user ||= User.new
  end
end
