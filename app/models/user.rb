class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }
  before_validation { email.downcase! }
  before_destroy :do_not_destroy_last_one_admin
  has_secure_password
  has_many :tasks, dependent: :destroy
  has_many :labels, dependent: :destroy

  private

  def do_not_destroy_last_one_admin
    if self.admin? && User.where(admin: :true).count == 1
      throw :abort
    end
  end
end