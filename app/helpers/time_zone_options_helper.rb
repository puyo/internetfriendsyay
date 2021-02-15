module TimeZoneOptionsHelper
  def time_zone_options(current_timezone, ip)
    if current_timezone
      tz = ActiveSupport::TimeZone.new(current_timezone)
      return {priority: priorities(tz)}
    end
    return {} if ip == '127.0.0.1' || ip.blank?
    results = Geocoder.search(ip)
    return {} if results.empty?
    tz_str = results.first.data['timezone']
    tz = ActiveSupport::TimeZone.new(tz_str)
    result = {}
    if tz
      normalized_tz = normalize_tz(tz)
      if normalized_tz
        result[:default] = normalized_tz.name
      end
    end
    keywords = results.flat_map do |r|
      [r.city, r.region, *r.data['timezone'].split('/')]
    end
    result[:priority] = Regexp.new(keywords.join('|'))
    result
  rescue
    {}
  end

  private

  def normalize_tz(tz)
    ActiveSupport::TimeZone.all.find {|t| t.tzinfo == tz.tzinfo }
  end

  def priorities(tz)
    all_priorities[tz_area(tz)]
  end

  def all_priorities
    @all_priorities ||= ActiveSupport::TimeZone.all.group_by {|t| tz_area(t) }
  end

  def tz_area(tz)
    tz.tzinfo.identifier.split('/').first
  end
end
