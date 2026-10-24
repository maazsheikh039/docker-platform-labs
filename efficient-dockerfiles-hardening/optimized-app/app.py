from flask import Flask, jsonify
import os
import platform
import sys
from datetime import datetime

app = Flask(__name__)

@app.route('/')
def get_info():
    return jsonify({
        'message': 'Optimized Docker Application',
        'hostname': os.uname().nodename,
        'platform': platform.platform(),
        'python_version': sys.version,
        'current_time': datetime.now().isoformat(),
        'environment': os.environ.get('ENVIRONMENT', 'development')
    })

@app.route('/health')
def health_check():
    return jsonify({'status': 'healthy'}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=int(os.environ.get('PORT', 5000)))
