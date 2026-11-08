import psycopg2
import redis

class HealthChecker:
    def __init__(self, db_dsn: str, redis_host: str, redis_port: int):
        self.db_dsn = db_dsn
        self.redis_host = redis_host
        self.redis_port = redis_port

    def check_database(self) -> bool:
        try:
            conn = psycopg2.connect(self.db_dsn, connect_timeout=2)
            cur = conn.cursor()
            cur.execute("SELECT 1;")
            cur.fetchone()
            cur.close()
            conn.close()
            return True
        except Exception:
            return False

    def check_cache(self) -> bool:
        try:
            client = redis.Redis(host=self.redis_host, port=self.redis_port, socket_timeout=2)
            return client.ping()
        except Exception:
            return False

    def report(self) -> dict:
        db_ok = self.check_database()
        cache_ok = self.check_cache()
        status = "ok" if (db_ok and cache_ok) else "degraded"
        return {
            "status": status,
            "db": "ok" if db_ok else "error",
            "cache": "ok" if cache_ok else "error"
        }
