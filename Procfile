web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
sidekiq: bundle exec sidekiq -c 5 -r ./lib/picto.rb -v
