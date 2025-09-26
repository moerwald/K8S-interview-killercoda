

const http = require('http');

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello from the fixed app!\n');
});

// INTENTIONAL BUG: The variable 'port' is misspelled as 'prt'
const hostname = '0.0.0.0';
const prt = 3000; // This is the bug!

server.listen(prt, hostname, () => {
  // This log message will never appear until the bug is fixed.
  console.log(`Server is running on port ${prt}`);
});