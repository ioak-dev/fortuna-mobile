const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = process.env.PORT || 3000;

app.use(bodyParser.json());

app.post('/api/228/user/auth/signin', (req, res) => {
  const { username, password } = req.body;

  if (username === 'elizabeth.taylor@ioak.org' && password === 'Authlite@123') {
    res.status(200).json({ success: true, username });
  } else {
    res.status(401).json({ success: false, error: 'Invalid credentials' });

  }
});

app.listen(port, () => {
  console.log(`Local server is running on port ${port}`);
});
