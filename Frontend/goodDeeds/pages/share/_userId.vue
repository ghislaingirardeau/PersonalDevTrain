<template>
    <div class="container align-items-center"> 
        <header class="row d-flex justify-content-around align-items-center my-3 pb-2 text-center header__display">
            <h3 class="col-12 col-lg-2 my-2">Be to feel</h3>
            <h3 class="col-12 col-lg-8 my-2 welcome--message">Bienvenue {{pseudo}}</h3>
            <nav class="col-12 col-lg-2 my-2">
              <NuxtLink to="/" @click.native="disconnect">Déconnexion</NuxtLink>
              <NuxtLink to="/home" >home</NuxtLink>
            </nav>
        </header> 
        
        <main class="row justify-content-around">
            <h2 class="col-12 mb-5 mt-1 text-center">Voici l'arbre de {{pseudo}}</h2>
            <tree :emotion="emotion" :key="reload"/>
        </main>       
        
    </div>
</template>

<script>
export default {
    data() {
        return {
            user_id: this.$route.params.id,
            reload: false,
            emotion: [],
            pseudo: String
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
                const getPseudo = data.results[1]
                this.pseudo= getPseudo[0].pseudo
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