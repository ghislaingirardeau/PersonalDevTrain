const express = require('express')
const feeling = require('../controllers/feeling')
const authentification = require('../middlewares/auth')

const router = express.Router()

router.get('/', authentification, feeling.allFeeling)
router.post('/', authentification, feeling.createFeeling)  /* expect { "user_id":"XXX" ,"topic": "XXXX"} */

router.put('/:feeling_id', authentification, feeling.modifyFeeling)   /* send topicId IN URL PARAMS */
router.delete('/:feeling_id', authentification, feeling.removeFeeling)   /* expect {"user_id":"XXX" ,"comment": "XXXX"} */

module.exports = router