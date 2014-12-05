class PartialDecorator < Draper::Decorator
  def to_partial_path(view = nil)
    if view.nil?
      object.to_partial_path
    else
      collection = ActiveSupport::Inflector.tableize(object.class.name)
      "#{collection}/#{String(view)}".freeze
    end
  end
end
