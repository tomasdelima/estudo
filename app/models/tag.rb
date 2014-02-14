class Tag < ActiveRecord::Base
  has_and_belongs_to_many :products
  validates :name, uniqueness: true, presence: true

  def self.return_tag name
    tag = Tag.find_by name: name
    if tag
      return tag
    else
      return Tag.create name: name
    end
  end
end
