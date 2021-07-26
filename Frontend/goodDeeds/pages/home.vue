<template>
<div class="container align-items-center" >
  <header class="row">
    <h3 class="col-4">Be to feel</h3>
    <h3 class="col-4">Bienvenue {{pseudo}}</h3>
    <nav class="col-4">
      <NuxtLink to="/" @click.native="disconnect">Déconnexion</NuxtLink>
    </nav>
  </header>
  
  <h1>Mon tableau de bord</h1>

  <main class="row">
    
    <article class="col-6">
      <h2>Mon arbre d'emotions</h2>

      <tree v-if="dataLoad" :emotion="emotion" :key="reload"/>
    </article>

    <feelingManage /> <!-- aside -->

  </main>
    

  

  
</div>
  
</template>

<script>

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
      this.pseudo = sessionStorage.getItem('pseudo')

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
                console.log(data)
                  data.negative.forEach(element => {
                      this.emotion.push(element.feeling_neg)
                  });
                  data.positive.forEach(element => {
                      this.emotion.push(element.feeling_pos)
                  });
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

<style>
path[class*='Vector'] {
  opacity: 0;
}

path[class*='appear'] {
  transform-origin: center;
  transform-box: fill-box;
  animation: feuille 4s forwards;

}

@keyframes feuille {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
  
}
</style>