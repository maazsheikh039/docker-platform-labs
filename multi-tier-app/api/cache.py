import redis

class CacheLayer:
    def __init__(self, host: str, port: int):
        self.client = redis.Redis(host=host, port=port, decode_responses=True)

    def get(self, key: str) -> str | None:
        try:
            return self.client.get(key)
        except redis.RedisError:
            return None

    def set(self, key: str, value: str, ttl_seconds: int) -> None:
        try:
            self.client.setex(key, ttl_seconds, value)
        except redis.RedisError:
            pass

    def invalidate(self, key: str) -> None:
        try:
            self.client.delete(key)
        except redis.RedisError:
            pass
