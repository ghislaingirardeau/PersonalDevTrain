<template>

  <div class="col-12">

    <h2 class="m-3">Renseignez les informations pour valider votre inscription :</h2>

    <form class="col-12">
      <label class="col-4 m-3" for="pseudo" >Mon pseudo</label>
      <input class="col-4 m-3" for="pseudo" id="pseudo" type="text"  v-model="post.pseudo" required> <!-- copie les données dans le data post  -->

      <label class="col-4 m-3" for="email" >Mon email</label>
      <input class="col-4 m-3" for="email" id="email" type="email"  v-model="post.email" required> <!-- copie les données dans le data post  -->

      <label class="col-4 m-3" for="password" >Mon mot de passe</label>
      <input class="col-4 m-3" for="password" id="password" type="password" v-model="post.password" placeholder="Minimum 6 lettres et un chiffre" required> <!-- copie les données dans le data post  -->
    </form>

    <div >
      <button class="m-3 p-2 button--layout" @click="postConnection('signup', post, errorMessage)">M'inscrire</button>
      <p class="message--error">{{errorMessage}}</p>
    </div>

  </div>

</template>

<script>

import {postConnection} from '@/store/functions'

export default {

  data () {
    return {
      post: {
        pseudo: null,
        email: null,
        password: null
      },
      errorMessage: null
    }
  },
  methods: {
    postConnection
  }
}
</script>