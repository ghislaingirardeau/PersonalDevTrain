const express = require('express')
const feeling = require('../controllers/feeling')
const authentification = require('../middlewares/auth')

const router = express.Router()

router.get('/', authentification, feeling.allFeeling)
router.post('/positive', authentification, feeling.createpositive)  /* expect { "user_id":"XXX" ,"feeling": "XXXX"} */
router.post('/negative', authentification, feeling.createnegative)

router.put('/:feeling_id', authentification, feeling.modifyFeeling)   /* send topicId IN URL PARAMS */
router.delete('/:feeling_id', authentification, feeling.removeFeeling)   /* expect {"user_id":"XXX" ,"comment": "XXXX"} */

module.exports = router