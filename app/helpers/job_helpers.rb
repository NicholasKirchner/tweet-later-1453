helpers do
  def job_is_complete(jid)
    waiting = Sidekiq::Queue.new
    working = Sidekiq::Workers.new
    pending = Sidekiq::ScheduledSet.new
    puts "jid: #{jid}"
    puts "waiting: #{waiting}"
    puts "working: #{working}"
    puts "pending: #{pending}"
    return false if pending.find { |job| job.jid == jid }
    return false if waiting.find { |job| job.jid == jid }
    return false if working.find { |worker, info| info["payload"]["jid"] == jid }
    true
  end
end