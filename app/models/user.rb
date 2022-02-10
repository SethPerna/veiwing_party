class User < ApplicationRecord
  has_many :user_parties
  has_many :parties, through: :user_parties

  validates_presence_of :name, :email

  def invites
    parties.where.not(host: id)
  end

  def hosting
    parties.where(host: id)
  end
end
