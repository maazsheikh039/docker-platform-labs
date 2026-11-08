import psycopg2
from datetime import datetime

class ItemStore:
    def __init__(self, dsn: str):
        self.dsn = dsn

    def list_items(self) -> list[dict]:
        conn = psycopg2.connect(self.dsn)
        cur = conn.cursor()
        cur.execute("SELECT id, name, created_at FROM items ORDER BY id DESC;")
        rows = cur.fetchall()
        items = []
        for row in rows:
            items.append({
                "id": row[0],
                "name": row[1],
                "created_at": row[2].isoformat() if isinstance(row[2], datetime) else str(row[2])
            })
        cur.close()
        conn.close()
        return items

    def create_item(self, name: str) -> dict:
        conn = psycopg2.connect(self.dsn)
        cur = conn.cursor()
        cur.execute("INSERT INTO items (name) RETURNING id, name, created_at;", (name,))
        row = cur.fetchone()
        conn.commit()
        item = {
            "id": row[0],
            "name": row[1],
            "created_at": row[2].isoformat() if isinstance(row[2], datetime) else str(row[2])
        }
        cur.close()
        conn.close()
        return item
