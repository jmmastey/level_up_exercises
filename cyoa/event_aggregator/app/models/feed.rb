class Feed < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  has_and_belongs_to_many :selection_criteria
  has_and_belongs_to_many :calendar_events

  def clear_events
    self.calendar_events.delete_all
  end

  def clear_criteria
    selection_criteria.delete_all
  end

  def capture_new_events
    self.class.connection.exec_update(update_events_statement)
  end

  protected

  def update_events_statement
    <<-EOF
      INSERT INTO calendar_events_feeds (calendar_event_id, feed_id)
        SELECT c.id, #{self.id}
        FROM calendar_events c
        #{where_clause}
        AND NOT EXISTS (
          SELECT 1 FROM calendar_events_feeds c2
          WHERE c2.calendar_event_id = c.id
          AND c2.feed_id = #{self.id}
        )
    EOF
  end 

  def where_clause
    terms = selection_criteria.map { |crit| sanitize_sql(*crit.sql_fragment) }
    terms << sanitize_sql("c.updated_at > '%s'", evaluated_at || created_at)
    "WHERE #{terms.join(' AND ')}"
  end

  def sanitize_sql(*sql_fragments)
    self.class.send(:sanitize_sql_for_conditions, sql_fragments)
  end
end
