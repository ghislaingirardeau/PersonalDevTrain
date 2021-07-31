<template>
<div class="container align-items-center" >
  <header class="row d-flex justify-content-around align-items-center mt-3 mb-3 pb-2 header__display">
    <h3 class="col-4">Be to feel</h3>
    <h3 class="col-4 text-center">Bienvenue {{pseudo}}</h3>
    <nav class="col-3 text-right">
      <NuxtLink to="/" @click.native="disconnect">Déconnexion</NuxtLink>
    </nav>
  </header>

  <main class="row">

    
    <article v-show="dataLoad" id="tree__bloc" class="col-8 load">
      <h2 class="mb-5 text-center">Mon arbre d'emotions</h2>

      <tree :emotion="emotion" :key="reload"/>
    </article>

    <feelingManage /> <!-- aside -->

  </main>
  
</div>
  
</template>

<script>
import { upperFirstLetter } from '@/store/functions'

export default {
    data () {
      return {
        emotion: [],
        reload: false,
        dataLoad: false,
        pseudo : String
      }
    },
    mounted () {
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
              response.json()
              .then(data => {
                /* Recupere toutes les emotions dans un tableau */
                  data.negative.forEach(element => {
                      this.emotion.push(element.feeling_neg)
                  });
                  data.positive.forEach(element => {
                      this.emotion.push(element.feeling_pos)
                  });
                  
                  const eltTree = document.getElementById("tree__bloc")
                  eltTree.classList.add("appear-0")
                  this.dataLoad = true
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
      disconnect() {
        sessionStorage.removeItem('token')
        sessionStorage.removeItem('userId')
        sessionStorage.removeItem('pseudo')
        sessionStorage.removeItem('role')
      }
    }
}
</script>

