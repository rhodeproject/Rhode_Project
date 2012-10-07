
# Learn more: http://github.com/javan/whenever
every 1.day, :at => '12:00 am' do
  rake "user:check_expiry"
end