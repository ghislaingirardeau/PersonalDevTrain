/* FUNCTION UPPERCASE USER NAME  */

export function upperFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1) 
}

/*  FUNCTION AXIOS FOR CONNECTION LOGIN AND SIGNUP */

import axios from "axios"
export function postConnection (connectionType, post) {
    const data = JSON.stringify(post)
      axios.post("http://localhost:3000/api/" + connectionType, data, {
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
      .catch((error) => this.errorMessage = error.response.data.message)
}

/*  CALL API FOR POSTFEELING */

export function postFeeling (feeling, kindOfFeel) {

    if(feeling != undefined) {
      let user_id = sessionStorage.getItem('userId')
      let token = sessionStorage.getItem('token')
      /* creer objet a envoyer */
      let postEmotion = {user_id: user_id, feeling: feeling}

      /* route qui varie suivant le type d'emotion pour avoir 2 tableau distinct coté sql */
      fetch(`http://localhost:3000/api/feeling/${kindOfFeel}`, {
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

/* DISCONNECTION */
export function disconnect() {
    sessionStorage.removeItem('token')
    sessionStorage.removeItem('userId')
    sessionStorage.removeItem('pseudo')
    sessionStorage.removeItem('role')
}

/* FUNCTION SHARING FEATURE */

export function shareRequest() {
    const checkDemand = this.$parent.userOndemand.findIndex((element) => element.pseudo === this.searchPseudo.toLowerCase())
    const checkShared = this.$parent.userShared.findIndex((element) => element.pseudo === this.searchPseudo.toLowerCase())
    if(checkShared != -1){
      console.log('Ce pseudo est deja autorisé')
      this.searchResults = "Ce pseudo est deja autorisé ou en cours de demande"
    }
    else if(checkDemand != -1){
      console.log('Ce pseudo vous a envoyé une demande')
      this.searchResults = "Ce pseudo vous a envoyé une demande"
    } else {
        const token = sessionStorage.getItem('token')
        const user_id = sessionStorage.getItem('userId')
        const dataShare = {searchPseudo: this.searchPseudo, user_id: user_id}
          fetch("http://localhost:3000/api/share/searchUser", {
              method: "POST",
              headers: {
              "content-type": "application/json",
              "Authorization" : 'Bearer ' + token
              },
              body: JSON.stringify(dataShare)
          })
          .then(response => {
              if(response.ok) {
                  response.json()
                  .then(data => {
                    if(data.message === 'undefined') {
                        this.searchResults = "Ce pseudo n'existe pas"
                    } else {
                      const newSharing = {connectTo: data.idFind, pseudo: this.searchPseudo, status: "on demand"}
                      this.$emit('update-sharing', {newSharing})
                    }
                  })
              } else { 
                response.json()
                .then(data => {
                  console.log(data) 
                })
              }
          })
        }

}

export function responseDemand(res, idFrom, pseudo) {
    const user_id = sessionStorage.getItem('userId')
    const token = sessionStorage.getItem('token')
    const dataShare = {responseStatus: res, user_id: user_id, idFrom: idFrom}
    fetch("http://localhost:3000/api/share/responseSharing", {
        method: "PUT",
        headers: {
        "content-type": "application/json",
        "Authorization" : 'Bearer ' + token
        },
        body: JSON.stringify(dataShare)
    })
    .then(response => {
        if(response.ok) {
            response.json()
            .then(data => {
              if(res === "authorized"){ /* si authorized alors je mets à jour le data des composants sans reload */
                /* met à jour le tableau share */
                const newSharing = {connectTo: idFrom, pseudo: pseudo, status: "authorized"}
                /* supprime le pseudo du tableau on demand  */
                const indexElement = this.userOndemand.findIndex((element) => element.pseudo === pseudo)
                this.$emit('update-sharing', {newSharing, indexElement})
              } else { /* si la reponse est un refus */
                console.log(data.message)
                const newSharing = undefined
                /* supprime le pseudo du tableau on demand  */
                const indexElement = this.userOndemand.findIndex((element) => element.pseudo === pseudo)
                this.$emit('update-sharing', {newSharing, indexElement})
              }
            })
        } else { 
          response.json()
          .then(data => {
            this.responseSharingResult = data.message
          })
        }
    })   
    this.$bvModal.hide('modal-demand')     
}

/* END SHARING FEATURE */