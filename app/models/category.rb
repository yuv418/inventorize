class Category < ApplicationRecord
  belongs_to :parent, optional: true, foreign_key: "parent_id", class_name: "Category"
  has_many :children, class_name: "Category", foreign_key: "parent_id"

  has_and_belongs_to_many :items

  validates :name, presence: true, uniqueness: true
end
