const sensorLib = require('node-dht-sensor')
const http = require('http')
const { InfluxDB, FieldType } = require('influx')

const influx = new InfluxDB({
  host: '10.144.195.61',
  database: 'metrics',
  username: 'root',
  password: '1nflux!',
  schema: [{
    measurement: 'temperature',
    fields: { value: FieldType.FLOAT },
    tags: ['device'],
  }, {
    measurement: 'humidity',
    fields: { value: FieldType.FLOAT },
    tags: ['device'],
  }, {
    measurement: 'vcc',
    fields: { value: FieldType.FLOAT },
    tags: ['device'],
  }],
})

const getSensorData = (type, pin) => new Promise((resolve, reject) => {
  sensorLib.read(type, pin, (err, temperature, humidity) => {
    if (err || (temperature === 0 && humidity === 0)) {
      reject(err || 'could not get sensor data')
      return
    }
    resolve({ temperature, humidity })
  })
})

const sendToInflux = (device, temperature, humidity, vcc) => {
  const points = [{
    measurement: 'temperature',
    tags: { device },
    fields: { value: temperature },
  }, {
    measurement: 'humidity',
    tags: { device },
    fields: { value: humidity },
  }]
  if (vcc) {
    points.push({
      measurement: 'vcc',
      tags: { device },
      fields: { value: vcc },
    })
  }

  return influx.writePoints(points)
}

setInterval(() => {
  getSensorData(22, 17)
    .then(({ temperature, humidity }) => sendToInflux('livingroom_dht22', temperature, humidity))
    .catch(err => console.error(err))
}, 5000)

const server = http.createServer((req, res) => {
  if (req.method == 'POST') {
    var body = ''
    req.on('data', (data) => { body += data })
    req.on('end', () => {
      res.writeHead(200, {'Content-Type': 'text/plain'})
      res.end('')

      const data = body && JSON.parse(body)
      const { device, temperature, humidity } = data || {}
      const vcc = ((data && data.vcc) || 0) / 1000
      console.log('got data from', device, { temperature, humidity, vcc })
      sendToInflux(device, temperature, humidity, vcc)
    })
  } else {
    res.writeHead(200, {'Content-Type': 'text/plain'})
    res.end('')
  }
})

server.listen(2742)

console.log('listening on port 2742');
