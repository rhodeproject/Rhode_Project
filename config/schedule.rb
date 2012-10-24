
# Learn more: http://github.com/javan/whenever
every 1.day, :at => '04:00 am' do
  rake "user:check_expiry"
end