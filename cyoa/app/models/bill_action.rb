class BillAction < ActiveRecord::Base
  belongs_to :bill

  scope :passed_senate, -> { where(result: 'pass', chamber: 'senate') }
  scope :passed_house, -> { where(result: 'pass', chamber: 'house') }
  scope :signed, -> { where(text: 'Signed by President.') }
  scope :vetoed, -> { where(text: 'Vetoed by President.') }
  scope :enacted, -> { where('text LIKE ?', '%Became Public Law%') }

  scope :recent, -> { where(date: (Time.zone.now - 24.hours)..Time.zone.now) }

  def self.important
    [passed_senate, passed_house, vetoed, signed, enacted].flatten
  end
end
