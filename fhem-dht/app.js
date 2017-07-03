const sensorLib = require('node-dht-sensor')
const net = require('net')

const getSensorData = (type, pin) => new Promise((resolve, reject) => {
  sensorLib.read(type, pin, (err, temperature, humidity) => {
    if (err || (temperature === 0 && humidity === 0)) {
      reject(err || 'could not get sensor data')
      return
    }
    resolve({ temperature, humidity })
  })
})

const netcat = (host, port, data) => new Promise((resolve, reject) => {
  const client = net.createConnection({ port, host }, () =>
    client.write(data, () => {
      client.end()
      resolve()
    })
  )
})

const round = (number) => Math.round(number * 10) / 10

const sendSensorData = (host, port, data) => new Promise(resolve => {
  let str = ''
  str += `setreading ${data.name} Temperature ${round(data.temperature)}\n`
  str += `setreading ${data.name} Humidity ${round(data.humidity)}\n`
  str += `setreading ${data.name} Error 0\n`
  netcat(host, port, str).then(resolve)
})

const sendError = (host, port, name) => new Promise(resolve =>
  netcat(host, port, `setreading ${name} Error 1\n`).then(resolve))

setInterval(() => {
  getSensorData(22, 17)
    .then(
      data =>
        sendSensorData('172.17.0.2', 7072, Object.assign(data, { name: 'livingroom_dht22' }))
          .then(
            () => console.log(data),
            err => console.error(err)
          ),
      err => console.error(err)
    )
}, 10000)
console.log('started')
