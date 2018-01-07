class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :votes, dependent: :delete_all

  def like(user)
  	increment!(:likes_count)
  	Vote.create(user_id: user.id, post_id: id)
  end

  def unlike(user, vote)
  	decrement!(:likes_count)
  	vote.destroy
  end
end
