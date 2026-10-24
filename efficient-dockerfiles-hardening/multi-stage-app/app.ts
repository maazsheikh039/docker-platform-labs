interface ServerInfo {
    hostname: string;
    platform: string;
    architecture: string;
    nodeVersion: string;
    currentTime: string;
    uptime: number;
}

import * as http from 'http';
import * as os from 'os';

const server = http.createServer((req: http.IncomingMessage, res: http.ServerResponse) => {
    const serverInfo: ServerInfo = {
        hostname: os.hostname(),
        platform: os.platform(),
        architecture: os.arch(),
        nodeVersion: process.version,
        currentTime: new Date().toISOString(),
        uptime: Math.floor(process.uptime())
    };

    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify(serverInfo, null, 2));
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
    console.log(`TypeScript server running on port ${PORT}`);
});
