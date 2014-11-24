class Alias < ActiveRecord::Base
  attr_accessor :add

  def self.query(text)
    best_topic = FreebaseAPI::Topic.search(text).values.first
    return [] if best_topic.nil?
    aliases = full_topic(best_topic.id).property('/common/topic/alias')
    Array(aliases).map do |_alias|
      new(text: _alias.value)
    end
  end

  private

  def self.full_topic(id)
    FreebaseAPI::Topic.get(id)
  end
end
