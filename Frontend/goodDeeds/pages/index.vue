<template>
<main class="container text-center border">
  <header class="border mt-4 mb-4">
    <h1>Bienvenue sur Be to Feel </h1>
    
  </header>

  <nav class="row">
    <div class="button__log col-12">
      <button class="m-3 p-2 button--layout" @click="showLogin">Se connecter</button>
    
      <button class="m-3 p-2 button--layout" @click="showSignup">S'inscrire</button>
    </div>
    
    <login v-if="login" :key="login"/>
    <signup v-if="signup" :key="signup"/>
  </nav>

  <article class="p-4">

    <h2 class="mb-4">Présentation du concept</h2>

    <p>Parce qu'il n'est jamais facile d'exprimer ces émotions... <br>
    Parce que nous n'avons pas la possibilité de visualiser notre évolution...<br>
    Ce projet a pour objectif très simple de proposer un outil permettant de visualiser et d'avoir une représentation 
    graphique de vos émotions à travers le temps.
    </p>
  
  </article>    

  

</main>
  
</template>

<script>


export default {
  data () {
    return {
      login: true,
      signup: false
      
    }
  },
  methods: {
    showLogin() {
        this.login = true
        this.signup = false
    },
    showSignup() {
        this.login = false
        this.signup = true
    }
  }


}
</script>

<style>

</style>
