class User < ApplicationRecord
    has_secure_password

    has_many :orders, -> { order(created_at: :asc) }, dependent: :delete_all
    has_many :billing_addresses, -> { order(created_at: :asc) }, dependent: :delete_all

    REGEX_PATTERN = /\A^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$\z/

    validates :username, presence: true, length: { in: 3..20},
              format: { with: /\A[a-zA-Z0-9]+\z/, message: "Only letters or numbers" }
    validates :password, presence: true , length: { in: 8..50 }
    validates :email, presence: true, uniqueness: { case_sensitive: false },
              format: { with: REGEX_PATTERN, message: "Enter a valid email" }


end