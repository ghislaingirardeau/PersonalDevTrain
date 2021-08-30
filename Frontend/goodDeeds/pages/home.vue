<template>
<div class="container align-items-center">
  <header class="row d-flex justify-content-around align-items-center my-3 pb-2 text-center header__display">
    <h3 class="col-12 col-lg-2 my-2">Be to feel</h3>
    <h3 class="col-12 col-lg-8 my-2 welcome--message">Bienvenue {{pseudo}}</h3>
    <nav class="col-12 col-lg-2 my-2">
      <NuxtLink to="/" @click.native="disconnect">Déconnexion</NuxtLink>
    </nav>
  </header>
  <nav class="row justify-content-center">
    <searchUser :userShared="userShared" :userOndemand="userOndemand" @update-sharing="updateUserShareArray"/>
  </nav>

  <main class="row justify-content-around">

    <transition name="fade" appear>
      <article v-if="dataLoad" class="col-12 col-xl-7">

        <h2 class="mb-5 mt-1 text-center">Mon arbre d'emotions</h2>
        <tree :emotion="emotion" :key="reload"/>

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
      }
    },
    created () {
      
      this.pseudo = upperFirstLetter(sessionStorage.getItem('pseudo'))
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
          }
          if(payload.indexElement != undefined){ /* supprime le user du tableau de demande quelsoit accepter ou rejeter */
            this.userOndemand.splice(payload.indexElement, 1)
          }
        }
    }
}
</script>

