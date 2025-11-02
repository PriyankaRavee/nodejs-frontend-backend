const request = require('supertest');
const app = require('./app');

describe('GET /api', () => {
  it('should return Hello from backend!', async () => {
    const res = await request(app).get('/api');
    expect(res.statusCode).toBe(200);
    expect(res.text).toBe('Hello from backend!');
  });
});
