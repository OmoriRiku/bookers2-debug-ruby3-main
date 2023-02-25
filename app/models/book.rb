class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      Book.where(["title like? or body like?","#{word}", "#{word}"])
    elsif search == "forward_match"
      Book.where(["title like? or body like?","#{word}%", "#{word}%"])
    elsif search == "backward_match"
      Book.where(["title like? or body like?","%#{word}", "%#{word}"])
    elsif search == "partial_match"
      Book.where(["title like? or body like?","%#{word}%", "%#{word}%"])
    else
      Book.all
    end
  end
  
end
