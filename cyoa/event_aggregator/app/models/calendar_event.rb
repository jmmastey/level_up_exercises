require "digest"

class CalendarEvent < ActiveRecord::Base
  belongs_to :event_source
  has_and_belongs_to_many :feeds

  before_save :refresh_derived_state

  def after_initialize
    state_is_consistent = true
  end

  def event_hash
    refresh_derived_state
    super
  end

  def family_hash
    refresh_derived_state
    super
  end

  def self.family_hash(params)
    Digest::SHA1.hexdigest(family_hash_string(params))
  end

  def self.event_hash(params)
    Digest::SHA1.hexdigest(event_hash_string(params))
  end

  protected

  attr_accessor :state_is_consistent

  def refresh_derived_state
    recompute_derived_state unless state_is_consistent
    state_is_consistent = true
  end

  def recompute_derived_state
    self.family_hash = self.class.family_hash(self)
    self.event_hash = self.class.event_hash(self)
  end

  def write_attribute(attr_name, value)
    state_is_consistent = false
    super
  end

  def self.event_hash_string(params)
    family_hash = family_hash_string(params)
    "#{family_hash}#{params[:start_time].to_i}#{params[:end_time].to_i}"
  end

  def self.family_hash_string(params)
    #source_name = params.respond_to?(:event_source) ? params.event_source.name
    #                                                : params[:event_source_name]
    "#{params[:source_name]}#{params[:title]}#{params[:location]}"
  end
end
