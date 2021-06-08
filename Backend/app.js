const express = require('express')

const users = require('./routes/user')
/* const topicRoutes = require('./routes/topic') */

const app = express()

/* Configuration du header */
app.use((req, res, next) => {
  res.setHeader('Access-Control-Allow-Origin', '*') /* * pour la soutenance, pour la presentation mettre le 8080 */
  res.setHeader('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content, Accept, Content-Type, Authorization')
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH')
  next()
})    

app.use(express.json())

app.use('/api/', users)
/* app.use('/api/sujet', topicRoutes) */

module.exports = app