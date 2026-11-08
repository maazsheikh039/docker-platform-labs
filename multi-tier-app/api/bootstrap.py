import time
import logging
import psycopg2

logger = logging.getLogger(__name__)

class DatabaseBootstrap:
    def __init__(self, dsn: str):
        self.dsn = dsn

    def wait_for_ready(self, host: str, port: int, timeout_seconds: int) -> bool:
        start_time = time.time()
        while time.time() - start_time < timeout_seconds:
            try:
                conn = psycopg2.connect(self.dsn)
                conn.close()
                return True
            except psycopg2.OperationalError:
                time.sleep(2)
        return False

    def apply_schema(self) -> None:
        conn = psycopg2.connect(self.dsn)
        cur = conn.cursor()
        cur.execute("""
            CREATE TABLE IF NOT EXISTS items (
                id SERIAL PRIMARY KEY,
                name VARCHAR(255) NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            );
        """)
        conn.commit()
        cur.close()
        conn.close()

    def seed_initial_data(self) -> int:
        conn = psycopg2.connect(self.dsn)
        cur = conn.cursor()
        cur.execute("SELECT COUNT(*) FROM items;")
        count = cur.fetchone()[0]
        if count == 0:
            cur.execute("INSERT INTO items (name) VALUES ('Initial Seed Item');")
            conn.commit()
            count = 1
        cur.close()
        conn.close()
        return count
