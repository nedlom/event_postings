class Event < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :date, presence: true
  validates :time, presence: true
end