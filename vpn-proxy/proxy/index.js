const http = require('http')
const qs = require('query-string')
const fetch = require('node-fetch')
require('console-stamp')(console)

const server = http.createServer((req, res) => {
  const { query } = qs.parseUrl(req.url)
  if (!query.url) {
    res.statusCode = 400
    res.end('no url provided')
    return
  }
  const headers = { ...req.headers }
  delete headers.host

  fetch(query.url, {
    headers,
  })
    .then(r => r.text())
    .then((text) => {
      console.log('fetched', query.url)
      res.end(text)
    })
    .catch((err) => {
      res.statusCode = 400
      console.error(err.toString())
      res.end(err.toString())
    })
})

server.listen(3000)
console.log('http proxy server started')
