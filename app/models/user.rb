class User < ActiveRecord::Base
  has_secure_password
  has_many :incomming_messages, class_name: "Message", foreign_key: "reciever_id"
  has_many :outcomming_messages, class_name: "Message", foreign_key: "sender_id"

  has_many :friends, :class_name => "Friend", :foreign_key => "from_id"
  has_many :passive_friends, :class_name => "Friend", :foreign_key => "to_id"
  has_many :active_friend, -> { where(friends: {accepted: true}) }, :through => :friends, :source => :to
  has_many :passive_friend, -> { where(friends: {accepted: true}) }, :through => :passive_friends, :source => :from

  validates :name, :presence => true
  validates :email, :uniqueness => true
end
