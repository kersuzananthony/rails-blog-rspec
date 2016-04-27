class Article < ActiveRecord::Base

  # Validations
  validates :title, presence: true
  validates :body, presence: true

  default_scope { order(:created_at => :desc) }

  # Associations
  belongs_to :user

end
