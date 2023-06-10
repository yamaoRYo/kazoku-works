module ApplicationHelper

  def render_turbo_stream_flash_messages
    turbo_stream.prepend "flash", partial: "layouts/flash"
  end

  def bootstrap_class_for(flash_type)
    case flash_type
    when "success"
      "success"  # green
    when "error"
      "danger"   # red
    when "alert"
      "warning"  # yellow
    when "notice"
      "info"     # blue
    else
      flash_type.to_s
    end
  end
end
