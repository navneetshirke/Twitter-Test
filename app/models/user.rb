class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :token_authenticatable

  has_many :authentication_tokens, dependent: :destroy
  has_many :tweets
  has_many :follows
  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :follower_relationships, foreign_key: :user_id, class_name: 'Follow'
  has_many :following, through: :follower_relationships, source: :following
end
