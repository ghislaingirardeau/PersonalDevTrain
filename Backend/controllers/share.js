/* CONNECTION MYSQL */
const mysql = require('mysql')
const config = require('../config')
const connection = mysql.createConnection(config)

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

exports.responseSharing = (req, res, next) => {

    const sql = `update sharing set status='${req.body.responseStatus}' where connectFrom='${req.body.idFrom}' 
    AND connectTo='${req.body.user_id}'`
    connection.query(sql, (error, results, fields) => {
        if (error) {
            res.status(400).json({message: "erreur envoie de réponse"})
        } else if (results) {
            res.status(200).json({message: "votre réponse a été envoyé"})
        }
    })
}