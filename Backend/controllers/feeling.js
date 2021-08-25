/* CONNECTION MYSQL */
const mysql = require('mysql')
const config = require('../config')
const connection = mysql.createConnection(config)


exports.allFeeling = (req, res, next) => { 

    const sql = `CALL user_connect("${req.body.user_id}")`
    connection.query(sql, (error, results, fields) => {

        if (error) {
            res.status(400).json({message: "echec"})
            console.log(error)
        } else if (results) {
            res.status(200).json({
                results                
            })
        }
    })
}

exports.searchUser = (req, res, next) => {

   const sql = `select id from user where pseudo='${req.body.searchPseudo}'`
   connection.query(sql, (error, results, fields) => {

       if (error) {
           res.status(400).json({message: "erreur de recherche"})
       } else if (results.length == 0) { /* si requete ne renvoie aucun pseudo alors renvoie un tableau vide */
            res.status(200).json({message: "Ce pseudo n'existe pas"})
       } else if (results.length > 0) { /* si j'ai un resultat et donc le pseudo existe */
            const idFind = results[0].id
            const sql = `INSERT INTO sharing (connectFrom, status, connectTo) VALUES (${req.body.user_id}, 'on demand', ${idFind})`
            connection.query(sql, (error, result, fields) => {
                if (error) {
                    res.status(400).json({message: "erreur insertion"})
                } else if (result) {
                    res.status(200).json({message: "demande de partage envoyé"})
                }
            })
       }
   })
}

exports.sharedFeeling = (req, res, next) => {
     /* test */
    const sql = `call user_share(${req.body.user_id})`
    connection.query(sql, (error, results, fields) => {

        if (error) {
            res.status(400).json({message: "echec"})
        } else if (results) {
            res.status(200).json({
                positive: results[0],
                negative: results[1]
            })
        }
    })
}

exports.createnegative = (req, res, next) => { 
    
    /* const sql = `CALL add_negative("${req.body.user_id}", "${req.body.feeling}")` */
    const sql = `INSERT INTO negative (feeling_neg, date, user_id)
    VALUES ("${req.body.feeling}", (SELECT NOW()), "${req.body.user_id}");`
    connection.query(sql, (error, results, fields) => {

        if (error) {
            res.status(400).json({message: 'echec de creation'})
        } else if (results) {
            res.status(200).json({message: 'Impression envoyé'})
        }
    })
}

exports.createpositive = (req, res, next) => { 
    
    /* const sql = `CALL add_positive("${req.body.user_id}", "${req.body.feeling}")` */
    const sql = `INSERT INTO positive (feeling_pos, date, user_id)
    VALUES ("${req.body.feeling}", (SELECT NOW()), "${req.body.user_id}");`
    connection.query(sql, (error, results, fields) => {

        if (error) {
            res.status(400).json({message: 'echec de creation'})
        } else if (results) {
            res.status(200).json({message: 'Impression envoyé'})
        }
    })
}

