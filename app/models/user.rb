class User < ApplicationRecord
    # adds virtual attributes for authentication
    has_secure_password
    has_many :tasks, foreign_key: 'creator_id'
    # validates email
    validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
end
