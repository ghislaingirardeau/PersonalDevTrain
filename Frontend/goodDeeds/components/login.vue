<template>

  <div class="col-12">

    <h2 class="m-3">Espace de connexion</h2>

    <form class="col-12 border">
      <label class="col-4 m-3" for="pseudo" >Mon pseudo</label>
      <input class="col-4 m-3" for="pseudo" id="pseudo" type="text"  v-model="post.pseudo" required> <!-- copie les données dans le data post  -->

      <label class="col-4 m-3" for="password" >Mot de passe</label>
      <input class="col-4 m-3" for="password" id="password" type="password" v-model="post.password" required> <!-- copie les données dans le data post  -->
    </form>  

    <div >
      <button class="m-3 p-2 button--layout" @click="postLogin">Envoyer</button>
      <p class="message--error">{{errorMessage}}</p>
    </div>


    <p>Si vous n'avez pas de compte cliquer sur "s'inscrire"</p>

  </div>

</template>

<script>
import axios from "axios"

export default {

  data () {
    return {
      post: {
        pseudo: null,
        password: null
      },
      errorMessage: null
    }
  },
  methods: {
    postLogin() { 
      const data = JSON.stringify(this.post)
      axios.post("http://localhost:3000/api/login", data, {
        headers: {
          "content-type": "application/json",
        },
      }) 
      .then(response => {
        
        sessionStorage.setItem('token', response.data.token)
        sessionStorage.setItem('userId', response.data.userId)
        sessionStorage.setItem('pseudo', response.data.pseudo)
        sessionStorage.setItem('role', response.data.role)
        window.open('/home', '_self')

      })
      .catch((error) => this.errorMessage = error.response.data.message)
    },
  },
}
</script>