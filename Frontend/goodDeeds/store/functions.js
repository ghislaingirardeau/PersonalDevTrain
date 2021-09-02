/* FUNCTION UPPERCASE USER NAME  */

export function upperFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1) 
}

/* MAJ array share users */

export function updateUserShareArray(payload) {
  if(payload.newSharing != undefined){ /* si reponse rejeté renvoie undefined = pas besoin de mettre a jour le tableau */
    this.userShared.push(payload.newSharing) /* ajout user autorisé */
    this.userOndemand.splice(payload.indexElement, 1)
  }
  else if(payload.indexElement != undefined){ /* supprime le user du tableau de demande quelsoit accepter ou rejeter */
    this.userOndemand.splice(payload.indexElement, 1)
  }
  else if(payload.updateOneShare != undefined){ /* supprime le user du tableau de demande quelsoit accepter ou rejeter */
    this.userShared.splice(payload.updateOneShare, 1)
  }
}


/* DISCONNECTION */
export function disconnect() {
    sessionStorage.removeItem('token')
    sessionStorage.removeItem('userId')
    sessionStorage.removeItem('pseudo')
    sessionStorage.removeItem('role')
}

