import os
from flask import Flask, jsonify, request
from bootstrap import DatabaseBootstrap
from store import ItemStore
from cache import CacheLayer
from health import HealthChecker

app = Flask(__name__)

DB_DSN = os.getenv("DATABASE_URL", "postgresql://appuser:secretpassword@db:5432/appdb")
REDIS_HOST = os.getenv("REDIS_HOST", "cache")
REDIS_PORT = int(os.getenv("REDIS_PORT", 6379))

bootstrap = DatabaseBootstrap(DB_DSN)
if not bootstrap.wait_for_ready("db", 5432, 30):
    raise RuntimeError("Database failed to become ready in time.")
bootstrap.apply_schema()
bootstrap.seed_initial_data()

store = ItemStore(DB_DSN)
cache = CacheLayer(REDIS_HOST, REDIS_PORT)
health_checker = HealthChecker(DB_DSN, REDIS_HOST, REDIS_PORT)

@app.route("/health", methods=["GET"])
def health():
    rep = health_checker.report()
    code = 200 if rep["status"] == "ok" else 503
    return jsonify(rep), code

@app.route("/items", methods=["GET"])
def list_items():
    cached_data = cache.get("items_list")
    if cached_data:
        import json
        return jsonify(json.loads(cached_data)), 200
    
    items = store.list_items()
    import json
    cache.set("items_list", json.dumps(items), 60)
    return jsonify(items), 200

@app.route("/items", methods=["POST"])
def create_item():
    data = request.get_json() or {}
    name = data.get("name")
    if not name:
        return jsonify({"error": "Missing 'name' field"}), 400
    
    item = store.create_item(name)
    cache.invalidate("items_list")
    return jsonify(item), 201

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
