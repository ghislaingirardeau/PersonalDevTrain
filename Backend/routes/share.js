const express = require('express')
const share = require('../controllers/share')
const authentification = require('../middlewares/auth')

const router = express.Router()

router.post('/searchUser', authentification, share.searchUser)
router.put('/responseSharing', authentification, share.responseSharing)
router.post('/feelingUser', share.feelingUser)

module.exports = router