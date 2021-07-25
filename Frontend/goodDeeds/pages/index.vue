<template>
<main>
  <header>
    <nav>
      <button @click="showLogin">Se connecter</button>
      <button @click="showSignup">S'inscrire</button>
    </nav>
    
  </header>

  <h1>Bienvenue sur Be to Feel </h1>

    <login v-if="login" :key="login"/>
    <signup v-if="signup" :key="signup"/>

  <h2>Présentation du concept</h2>

  <p>Visualiser comment evolue vos emtions dans le temps</p>
  

</main>
  
</template>

<script>


export default {
  data () {
    return {
      login: false,
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
