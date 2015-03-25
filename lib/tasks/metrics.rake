desc 'Gather metrics for usage'
task metrics: :environment do
  Rails.logger = nil
  ActiveRecord::Base.logger = nil

  users = User.where('created_at > ?', 30.days.ago).count
  signups = Signup.where('created_at > ?', 30.days.ago).count
  influentials = Signup.where('created_at > ?', 30.days.ago).where(influential: true).count
  active = Signup.where('created_at > ?', 30.days.ago).group(:user_id).count.map { |a, c| [User.find(a).email, c] }.sort_by(&:last).reverse
  top_active = active.take(10)

  puts "Last 30 days"
  puts "------------"
  puts "Users created: #{users}"
  puts "Signups checked: #{signups}"
  puts "Influential signups checked: #{influentials}"
  puts "Active accounts: #{active.count}"
  puts "Top #10 accounts by signup count:"
  active.each do |account, count|
    puts "  #{account}: #{count}"
  end

  puts

  users = User.count
  signups = Signup.count
  influentials = Signup.where(influential: true).count
  active = Signup.group(:user_id).count.map { |a, c| [User.find(a).email, c] }.sort_by(&:last).reverse
  top_active = active.take(10)

  puts "All time"
  puts "--------"
  puts "Users created: #{users}"
  puts "Signups checked: #{signups}"
  puts "Influential signups checked: #{influentials}"
  puts "Active accounts: #{active.count}"
  puts "Top #10 accounts by signup count:"
  active.each do |account, count|
    puts "  #{account}: #{count}"
  end
end
