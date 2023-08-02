module ApplicationHelper
  # フラッシュメッセージを表示する
  def render_turbo_stream_flash_messages
    turbo_stream.update "flash", partial: "layouts/flash"
  end

  # フラッシュメッセージのクラスを設定する
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

  # 画像を表示する
  def default_url
    'default.png'
  end
end
