class LessonActivityDecorator < PartialDecorator
  delegate_all

  def type
    'Lesson material'.freeze
  end

  def next_page_text
    'Next page'.freeze
  end
end
