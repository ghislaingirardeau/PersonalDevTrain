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
import axios from "axios"

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
      const data = JSON.stringify(this.post)
      axios.post("http://localhost:3000/api/signup", data, {
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