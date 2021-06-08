/* CONNECTION MYSQL */
const mysql = require('mysql')
const config = require('../config')
const connection = mysql.createConnection(config)


exports.allFeeling = (req, res, next) => { 
    
    const sql = `XXX`
    connection.query(sql, (error, results, fields) => {

        if (error) {
            res.status(400).json({})
        } else if (results) {
            res.status(200).json({})
        }
    })
}

exports.createFeeling = (req, res, next) => { 
    
    const sql = `XXX`
    connection.query(sql, (error, results, fields) => {

        if (error) {
            res.status(400).json({})
        } else if (results) {
            res.status(200).json({})
        }
    })
}

exports.modifyFeeling = (req, res, next) => { 
    
    const sql = `XXX`
    connection.query(sql, (error, results, fields) => {

        if (error) {
            res.status(400).json({})
        } else if (results) {
            res.status(200).json({})
        }
    })
}

exports.removeFeeling = (req, res, next) => { 
    
    const sql = `XXX`
    connection.query(sql, (error, results, fields) => {

        if (error) {
            res.status(400).json({})
        } else if (results) {
            res.status(200).json({})
        }
    })
}