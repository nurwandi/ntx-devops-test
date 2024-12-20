import os from 'os';
import http from 'http';

// Define the request handler
function handleRequest(req, res) {
  res.write(`Hi there! I'm being served from ${os.hostname()}`);
  res.end();
}

// Create the server
const server = http.createServer(handleRequest);

// Export server and handler
export { server, handleRequest };

// Ensure server starts only if this is the entry point
if (import.meta.url.endsWith('/index.js')) {
  server.listen(3000, '0.0.0.0', () => {
    console.log('Server is running on port 3000');
  });
}