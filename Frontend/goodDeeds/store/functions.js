/* FUNCTION UPPERCASE USER NAME  */

export function upperFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1) 
}

/*  FUNCTION AXIOS FOR CONNECTION LOGIN AND SIGNUP */

import axios from "axios"
export function postConnection (connectionType, post, errorMessage) {
    const data = JSON.stringify(post)
      axios.post("https://apigooddeeds.herokuapp.com/api/" + connectionType, data, {
        headers: {
          "content-type": "application/json",
        },
      }) 
      .then(response => {
        
        sessionStorage.setItem('token', response.data.token)
        sessionStorage.setItem('userId', response.data.userId)
        sessionStorage.setItem('pseudo', response.data.pseudo)
        sessionStorage.setItem('role', response.data.role)
        window.open('/home', '_self')

      })
      .catch((error) => errorMessage = error.response.data.message)
}

/*  CALL API FOR POSTFEELING */

export function postFeeling (feeling, kindOfFeel) {

    if(feeling != undefined) {
      let user_id = sessionStorage.getItem('userId')
      let token = sessionStorage.getItem('token')
      /* creer objet a envoyer */
      let postEmotion = {user_id: user_id, feeling: feeling}

      /* route qui varie suivant le type d'emotion pour avoir 2 tableau distinct coté sql */
      fetch(`https://apigooddeeds.herokuapp.com/api/feeling/${kindOfFeel}`, {
          method: "POST",
              headers: {
              "content-type": "application/json",
              "Authorization" : 'Bearer ' + token
              },
          body: JSON.stringify(postEmotion)
      })
      .then(response => {
          if(response.ok){
              response.json()
              .then(data => {
                  console.log(data)
              })
          } else {
              response.json()
              .then(data => {
                  console.log(data)
              })
          }
      })
      /* envoie la nouvelle emotion dans le tableau arbre et reload le composant */
      this.$parent.emotion.push(feeling)
      this.$parent.reload = !this.$parent.reload
      /* compteur temps pour une prochaine activation des boutons */
      let timeValidation = Math.round(Date.now() / 1000)
      localStorage.setItem('lastValidation', timeValidation);

  } else {
      console.log('selectionner une emotion')
  }  
}

