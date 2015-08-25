class Bill < ActiveRecord::Base
  include PgSearch
  multisearchable against: [:official_title, :short_title, :summary_short]

  validates :bill_id, uniqueness: true
  belongs_to :legislator

  has_many :bill_tags, dependent: :destroy
  has_many :tags, through: :bill_tags

  has_many :bill_actions, dependent: :destroy

  BILL_TYPES = { 'hr' => 'H.R.', 's' => 'S.', 'hres' => 'H.Res.',
                 'sres' => 'S.Res.', 'sjres' => 'S.J.Res.',
                 'hjres' => 'H.J.Res.', 'hconres' => 'H.Con.Res.',
                 'sconres' => 'S.Con.Res.' }

  def type_and_num
    bill_num = /[a-z]*(\d*)-\d*/.match(bill_id)[1]
    bill_type_abbreviation = BILL_TYPES[bill_type]
    "#{bill_type_abbreviation} #{bill_num}"
  end

  def to_param
    bill_id
  end
end
