#!/usr/bin/env node

'use strict';

const dotenv = require('dotenv');
const slackin = require('slackin');


// Load environment variables from .env file
dotenv.config();

const port = process.env.SLACKIN_PORT || 5555;
const token = process.env.SLACKIN_TOKEN || '';

const app = slackin.default({
  org: 'hashicorpkr',
  token: token,
  path: '/',
  interval: 1000,
  channels: '',
  silent: false
});

// Start server
if (!module.parent) {
  app.listen(port, () => {
    console.log(`App server listening on ${port}`);
  });
}

// Expose app
module.exports = app;
