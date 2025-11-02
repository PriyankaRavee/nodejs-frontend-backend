const express = require('express');
const app = express();
app.get('/api', (req, res) => res.send('Hello from backend!'));
// Export app for testing
module.exports = app;

// Only start server if not in test environment
if (require.main === module) {
  app.listen(3000, () => console.log('Backend running on port 3000'));
}
