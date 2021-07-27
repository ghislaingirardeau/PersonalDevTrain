<template>

  <div id="login">

    <h2>Espace de connection</h2>

    <label for="pseudo" >Mon pseudo</label>
    <input for="pseudo" id="pseudo" type="text"  v-model="post.pseudo" required> <!-- copie les données dans le data post  -->
      
    <label for="password" >Mot de passe</label>
    <input for="password" id="password" type="password" v-model="post.password" required> <!-- copie les données dans le data post  -->
      
    <div >
      <button @click="postLogin">Envoyer</button>
      <p>{{errorMessage}}</p>
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
      .catch(() => console.log({message: "erreur de connexion"}))
    },
  },
}
</script>