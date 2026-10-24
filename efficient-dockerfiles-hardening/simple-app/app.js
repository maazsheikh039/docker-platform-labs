const http = require('http');
const os = require('os');

const server = http.createServer((req, res) => {
    res.writeHead(200, { 'Content-Type': 'text/html' });
    res.end(`
        <h1>Simple Docker App</h1>
        <p>Hostname: ${os.hostname()}</p>
        <p>Platform: ${os.platform()}</p>
        <p>Architecture: ${os.arch()}</p>
        <p>Node.js Version: ${process.version}</p>
        <p>Current Time: ${new Date().toISOString()}</p>
    `);
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
