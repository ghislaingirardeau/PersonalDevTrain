/*  FUNCTION AXIOS FOR CONNECTION LOGIN AND SIGNUP */

import axios from "axios"
export function postConnection (connectionType, post) {

  /* TEST NUXT AUTH 
  this.$auth.loginWith('local', {
    data: post
  })
  .then(user => {
    this.$auth.setUser(user)
    }) */
    const data = JSON.stringify(post)
      axios.post("http://localhost:3000/api/" + connectionType, data, {
        headers: {
          "content-type": "application/json",
        },
      }) 
      .then(response => {
        
        sessionStorage.setItem('token', response.data.token)
        sessionStorage.setItem('userId', response.data.userId)
        sessionStorage.setItem('pseudo', response.data.pseudo)
        sessionStorage.setItem('role', response.data.role)
        sessionStorage.setItem('avatar', response.data.avatar)
        this.$router.push('home')

      })
      .catch((error) => this.errorMessage = error.response.data.message)
}