class Alias < ActiveRecord::Base
  attr_accessor :add

  def self.query(text)
    best_topic = FreebaseAPI::Topic.search(text).values.first
    return [] if best_topic.nil?
    aliases = full_topic(best_topic.id).property('/common/topic/alias')
    Array(aliases).map do |alias_object|
      new(text: alias_object.value)
    end
  end

  def self.full_topic(id)
    FreebaseAPI::Topic.get(id)
  end
end
