class Objsecship < ActiveRecord::Base
  belongs_to :objeto
  belongs_to :sector
  
  validates :objeto_id, presence: true
  validates :sector_id, presence: true
  validates :objeto_id, uniqueness: {scope: :sector_id}
end
