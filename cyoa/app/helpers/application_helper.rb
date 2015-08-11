module ApplicationHelper
  def alert_class_for flash_type
    types = { success: "alert-success",
              error: "alert-danger",
              alert: "alert-warning",
              notice: "alert-info" }
    types[flash_type.to_sym] || flash_type.to_s
  end
end
