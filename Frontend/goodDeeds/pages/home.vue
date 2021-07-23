<template>
<div :key="reload">
  <h1>Mon tableau de bord émotionnel</h1>
  <NuxtLink to="/">Connexion</NuxtLink>
    <feelingManage />

  <h2>Mon arbre d'emotions</h2> {{reload}}

  <tree :getPositive="positive" :getNegative="negative" />
</div>
  
</template>

<script>

export default {
    data () {
      return {
        positive: Object,
        negative: Object,
        reload: false
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
                    this.positive = data.positive
                    console.log(typeof(this.positive))
                    this.negative = data.negative
                })
            } else { /* sinon j'envoie une erreur */
              response.json()
              .then(data => {
                console.log(data) /* renvoie error du backend sur le frontend */
              })
            }
        })
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