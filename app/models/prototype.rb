class Prototype < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  # active_storageを導入したためprototypeモデルと画像を紐付ける
  has_one_attached :image

  validates :title, presence: true
  validates :catch_copy, presence: true
  validates :concept, presence: true
  validates :image, presence: true
end
