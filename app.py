from flask import Flask, jsonify
import subprocess

app = Flask(__name__)

@app.route('/run-script', methods=['POST'])
def run_script():
    try:
        # Run the shell script
        result = subprocess.run(['./tb.sh'], capture_output=True, text=True, check=True)
        return jsonify({'message': 'Script executed successfully', 'output': result.stdout}), 200
    except subprocess.CalledProcessError as e:
        return jsonify({'message': 'Script execution failed', 'error': e.stderr}), 500
    except OSError as e:
        return jsonify({'message': 'OS error', 'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
