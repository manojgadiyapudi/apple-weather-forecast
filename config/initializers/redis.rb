Redis.current = Redis.new(host: Figaro.env.redis_host, port: Figaro.env.redis_port, db: Figaro.env.redis_db)
