<template>

  <div id="login">

    <h2>Veuillez vous identifier :</h2>

    <label for="pseudo" >Mon pseudo</label>
    <input for="pseudo" id="pseudo" type="text"  v-model="post.pseudo" required> <!-- copie les données dans le data post  -->
      
    <label for="password" >Mot de passe</label>
    <input for="password" id="password" type="password" v-model="post.password" required> <!-- copie les données dans le data post  -->
      
    <div class="col-12">
      <button @click="postLogin">Envoyer</button>
      <p>{{errorMessage}}</p>
    </div>


    <p>Si vous n'avez pas de compte cliquer sur "s'inscrire"</p>

  </div>

</template>

<script>
export default {
  name: "login",
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
      fetch("http://localhost:3000/api/login", {
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