<template>
<main align-items-center>
  <NuxtLink to="/" @click.native="disconnect">Déconnexion</NuxtLink>
  <h1>Mon tableau de bord émotionnel</h1>

    <feelingManage />

  <h2>Mon arbre d'emotions</h2>

  <tree v-if="dataLoad" :emotion="emotion" :key="reload"/>
</main>
  
</template>

<script>

export default {
    data () {
      return {
        emotion: [],
        reload: false,
        dataLoad: false
      }
    },
    mounted () {

        fetch("http://localhost:3000/api/feeling/", {
            method: "GET",
            headers: {
            "content-type": "application/json",
            },
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
        console.log('suppr data')
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