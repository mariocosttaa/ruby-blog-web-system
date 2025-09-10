# app/helpers/time_helper.rb
module TimeHelper
  def time_ago(time)
    return nil if time.nil?

    seconds = (Time.now - time).to_i
    minutes = (seconds / 60).to_i
    hours   = (minutes / 60).to_i
    days    = (hours / 24).to_i
    weeks   = (days / 7).to_i
    months  = (days / 30).to_i
    years   = (days / 365).to_i

    case seconds
    when 0..59
      "now"
    when 60..3599
      "#{minutes} minut#{'s' unless minutes == 1} ago"
    when 3600..86_399
      "#{hours} hour#{'s' unless hours == 1} ago"
    when 86_400..604_799
      "#{days} day#{'s' unless days == 1} ago"
    when 604_800..2_629_799
      "#{weeks} week#{'s' unless weeks == 1} ago"
    when 2_629_800..31_556_926
      "#{months} month#{'es' unless months == 1} ago"
    else
      "#{years} yar#{'s' unless years == 1} ago"
    end
  end
end
