class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user

  # Validations
  validates :body, presence: true

  def self.persisted
    where.not(id: nil)
  end
end
