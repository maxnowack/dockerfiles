const sensorLib = require('node-dht-sensor')
const librato = require('librato-node')

const SENSOR_TYPE = parseInt(process.env.SENSOR_TYPE, 10) || 22
const SENSOR_PIN = parseInt(process.env.SENSOR_PIN, 10)
const INTERVAL = parseInt(process.env.INTERVAL, 10) || 10000
const EMAIL = process.env.EMAIL
const TOKEN = process.env.TOKEN
const DEVICE = process.env.DEVICE

if (![11, 22].includes(SENSOR_TYPE)) {
  console.log('SENSOR_TYPE must be 11 or 22. Got', SENSOR_TYPE)
  console.log('exiting …')
  process.exit(1)
}
if (!SENSOR_PIN) {
  console.log('SENSOR_PIN is missing.')
  console.log('exiting …')
  process.exit(1)
}
if (!isFinite(INTERVAL)) {
  console.log('INTERVAL must be a valid number. Got', INTERVAL)
  console.log('exiting …')
  process.exit(1)
}
if (!DEVICE) {
  console.log('DEVICE is missing.')
  console.log('exiting …')
  process.exit(1)
}
if (!EMAIL) {
  console.log('EMAIL is missing.')
  console.log('exiting …')
  process.exit(1)
}
if (!TOKEN) {
  console.log('TOKEN is missing.')
  console.log('exiting …')
  process.exit(1)
}

console.log('config loaded', {
  SENSOR_TYPE,
  SENSOR_PIN,
  INTERVAL,
})

librato.configure({ email: EMAIL, token: TOKEN, period: 10000 })

const getSensorData = (type, pin) => new Promise((resolve, reject) => {
  sensorLib.read(type, pin, (err, temperature, humidity) => {
    if (err || (temperature === 0 && humidity === 0)) {
      reject(err || 'could not get sensor data')
      return
    }
    resolve({ temperature, humidity })
  })
})

const measure = ({ temperature, humidity }) => {
  librato.measure(`${DEVICE}_temperature`, temperature)
  librato.measure(`${DEVICE}_humidity`, humidity)
}

const getData = () => getSensorData(SENSOR_TYPE, SENSOR_PIN)
  .then(measure)
  .then(() => setTimeout(getData, INTERVAL))
  .catch((err) => {
    console.log(err)
    setTimeout(getData, INTERVAL)
  })

librato.start()
getData()
