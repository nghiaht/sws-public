const express = require('express');

const app = express();

app.get('/', (req, res) => {
    res.send('Hi');
})


// This is the sample
// Replace the content after /acme-challange/<content1>
// And the response res.send(<content2>)
app.get('/.well-known/acme-challenge/XuHDyYGSjaQNhRcxfGuUlrjCnRzqHCsHE8PM-fdN0Uo', (req, res) => {
    res.send('XuHDyYGSjaQNhRcxfGuUlrjCnRzqHCsHE8PM-fdN0Uo.owlbvjxo2wcd-H7GYFhW3fWqwZ9RIanVFAqRvVq7Z8g');
})

app.listen(80, () => {
    console.log('HTTP server running on port 80');
  });

  