module ApplicationHelper

  def render_turbo_stream_flash_messages
    turbo_stream.update "flash", partial: "layouts/flash"
  end

  def bootstrap_class_for(flash_type)
    case flash_type.to_sym
    when :success
      "success"
    when :error, :alert, :danger
      "danger"
    when :notice, :info
      "info"
    else
      flash_type.to_s
    end
  end
end
