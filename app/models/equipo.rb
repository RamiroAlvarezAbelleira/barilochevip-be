class Equipo < ApplicationRecord
  include PgSearch::Model

  belongs_to :category
  belongs_to :marca
  has_many :bookings
  has_many_attached :images

  pg_search_scope :global_search, against: [:name, :description], using: {
    tsearch: { prefix: true } # You can customize the search configuration here
  }
end
