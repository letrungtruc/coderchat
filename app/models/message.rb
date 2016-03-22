class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :reciever, class_name: 'User'

  validates :body, presence: true
  validates :reciever, presence: true
  validates :sender, presence: true
end
