<template>
    <main>
        <NuxtLink to="/home" >home</NuxtLink>
        <h2>{{user_id}}</h2>
        <tree :emotion="emotion" :key="reload"/>
        
    </main>
</template>

<script>
export default {
    data() {
        return {
            user_id: this.$route.params.id,
            reload: false,
            emotion: []
        }
    },
    mounted () {
      
      let token = sessionStorage.getItem('token')
      const userFeel = {user_id: this.user_id}
      
      fetch("http://localhost:3000/api/share/feelingUser", {
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
                this.reload = !this.reload
              })
          } else { /* sinon j'envoie une erreur */
            response.json()
            .then(data => {
              console.log(data.message) /* renvoie error du backend sur le frontend */
            })
          }
      })
    },
}
</script>