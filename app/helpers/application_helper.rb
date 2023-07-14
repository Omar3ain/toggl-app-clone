module ApplicationHelper
  def format_time(seconds)
    hours = seconds / 3600
    minutes = (seconds % 3600) / 60
    seconds = seconds % 60
    format("%02d:%02d:%02d", hours, minutes, seconds)
  end
end
