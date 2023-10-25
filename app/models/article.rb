class Article < ApplicationRecord
  def self.search(search)
    if search
      where('title ILIKE ? OR content ILIKE ?', "%#{search}%", "%#{search}%")
    else
      all
    end
  end
end
