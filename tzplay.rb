require 'tzinfo'
require 'pp'

def next_monday(tz)
  result = tz.now
  while not result.monday?
    result += 60*60*24 # one day
  end
  result = Time.utc(result.year, result.month, result.day) # round off minutes and seconds
  tz.local_to_utc(result)
end

syd = TZInfo::Timezone.get('Australia/Sydney')
p "Monday, Sydney time = #{syd.utc_to_local(next_monday(syd))}"

HOURS_PER_WEEK = 7*24
OFFSETS_PER_WEEK = HOURS_PER_WEEK*2

data = [
  {:id => 1, :tz => 'Australia/Sydney', :offsets => [0, 1]},
  {:id => 2, :tz => 'America/New_York', :offsets => [0, 310]},
  {:id => 3, :tz => 'Australia/Adelaide', :offsets => [0, 1]},
]

target = TZInfo::Timezone.get('Australia/Sydney')
target_mon = next_monday(target)
data.each do |row|
  source = TZInfo::Timezone.get(row.delete(:tz))
  source_mon = next_monday(source)
  times = row[:offsets].map{|offset| source_mon + offset*60*30 }
  row[:offsets] = times.map{|time| (time.to_i - target_mon.to_i)/60 % (OFFSETS_PER_WEEK*30) }
end

pp data
puts

# intervals...
#
# :intervals => [[0, 30], [60, 90]]
# :intervals => [[15, 45], [75, 105]]
#
# ...split if it runs over, later
