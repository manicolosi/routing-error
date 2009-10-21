class User < ActiveRecord::Base
  acts_as_authentic

  def to_param
    username
  end
end
