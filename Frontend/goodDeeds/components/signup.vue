<template>

  <div class="col-12">

    <h2 class="m-3">Renseignez les informations pour valider votre inscription :</h2>

    <form class="col-12 border">
      <label class="col-4 m-3" for="pseudo" >Mon pseudo</label>
      <input class="col-4 m-3" for="pseudo" id="pseudo" type="text"  v-model="post.pseudo" required> <!-- copie les données dans le data post  -->

      <label class="col-4 m-3" for="email" >Mon email</label>
      <input class="col-4 m-3" for="email" id="email" type="email"  v-model="post.email" required> <!-- copie les données dans le data post  -->

      <label class="col-4 m-3" for="password" >Mot de passe</label>
      <input class="col-4 m-3" for="password" id="password" type="password" v-model="post.password" required> <!-- copie les données dans le data post  -->
    </form>

    <div >
      <button class="m-4" @click="postSignup">M'inscrire</button>
      <p class="message--error">{{errorMessage}}</p>
    </div>

  </div>

</template>

<script>
export default {

  data () {
    return {
      post: {
        pseudo: null,
        pseudo: null,
        password: null
      },
      errorMessage: null
    }
  },
  methods: {
    postSignup() { 
      fetch("http://localhost:3000/api/signup", {
      method: 'POST',
      headers: {
        "content-type": "application/json",
        },
      body: JSON.stringify(this.post)
      })
      .then (res => {
        if(res.ok) { /* si reponse est ok, je recupere le data */
          res.json()
          .then (data => {
            /* envoie le token et le id dans la session storage pour recup sur la page home */  
            sessionStorage.setItem('token', data.token)
            sessionStorage.setItem('userId', data.userId)
            sessionStorage.setItem('pseudo', data.pseudo)
            sessionStorage.setItem('role', data.role)
            window.open('/home', '_self')

          })
        } else { /* sinon j'envoie une erreur */
          res.json()
          .then(data => {
            this.errorMessage = "erreur du serveur" /* renvoie error du backend sur le frontend */
          })
        }
      })
      .catch(() => console.log({message: "erreur de connexion"}))
    },
  },
}
</script>