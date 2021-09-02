<template>
<div class="container align-items-center">
  <headerBar :pseudo="pseudo">
    <NuxtLink to="/" @click.native="disconnect">Déconnexion</NuxtLink>
  </headerBar>
  <nav class="row justify-content-center">
    <searchUser :userShared="userShared" :userOndemand="userOndemand" @update-sharing="updateUserShareArray"/>
  </nav>

  <main class="row justify-content-around">

    <transition name="fade" appear>
      <article v-if="dataLoad" class="col-12 col-xl-7">

        <h2 class="mb-5 mt-1 text-center">Mon avatar d'emotions</h2>
        <emoImage :avatar="avatar" :emotion="emotion" :key="reload"/>

      </article>
    </transition>

    <feelingManage /> 

  </main>
  
</div>
  
</template>

<script>
import { upperFirstLetter, disconnect } from '@/store/functions'

export default {
    data () {
      return {
        emotion: [], /* Array 3 results call api */
        reload: false, /* reload tree component */
        dataLoad: false, /* a la reception des donnees de l'api */
        pseudo : String,
        userShared: [], /* Array 2 results call api */
        userOndemand: [], /* Array 3 results call api */
        avatar: String
      }
    },
    created () {
      
      this.pseudo = upperFirstLetter(sessionStorage.getItem('pseudo'))
      this.avatar = sessionStorage.getItem('avatar')
      let user_id = sessionStorage.getItem('userId')
      let token = sessionStorage.getItem('token')
      const userFeel = {user_id: user_id}
      
      fetch("http://localhost:3000/api/feeling/", {
          method: "POST",
          headers: {
          "content-type": "application/json",
          "Authorization" : 'Bearer ' + token
          },
          body: JSON.stringify(userFeel)
      })
      .then(response => {
          if(response.ok) {
            this.dataLoad = true /* affiche le composant lorsque la reponse arrive */
              response.json()
              .then(data => {
                /* Recupere toutes les emotions dans un tableau */
                data.results[0].forEach(element => {
                    this.emotion.push(element.feel)
                });
                this.userShared = data.results[1]
                this.userOndemand = data.results[2]
                this.reload = !this.reload
              })
          } else { /* sinon j'envoie une erreur */
            response.json()
            .then(data => {
              console.log(data) /* renvoie error du backend sur le frontend */
            })
          }
      })
    },
    methods: {
      disconnect,
      updateUserShareArray(payload) {
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
    }
}
</script>

