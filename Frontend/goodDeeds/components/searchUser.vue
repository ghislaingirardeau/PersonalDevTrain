<template>
    <article class="col-12 col-xl-7" >
      <h3>Rechercher une personne</h3>
      <label for="searchPseudo"></label>
      <input type="text" for="searchPseudo" v-model="searchPseudo" > 
      <button @click="shareRequest">Demande de partage</button>
      <p>{{searchResults}}</p>
      
      <h3>Mes personnes suivies</h3>
      <div v-for="user in userShared" :key="user.connectTo">
        <h4 v-if="user.status === 'authorized'">
          <NuxtLink :to="{ name: 'share-userId', params: {id: user.connectTo}}">{{user.pseudo}}</NuxtLink>
        </h4>
        <div v-if="user.status === 'on demand'">
          <h3 >mes demandes en attente </h3>
          <h4>{{user.pseudo}}</h4>
        </div>
      </div>

      <h3>Demande de suivi en attente</h3>
      <div v-for="user in userOndemand" :key="user.connectfrom">
        <p>demande de {{user.pseudo}} {{user}}</p>
        <button @click="responseDemand('authorized', user.connectfrom)">accepter</button>
        <button @click="responseDemand('rejected', user.connectfrom)">refuser</button>
      </div>
      <strong>{{responseSharingResult}}</strong>
    </article>

</template>

<script>
export default {
    data() {
        return{
          searchPseudo: '',
          searchResults: '',
          responseSharingResult: ''
        }
    },
    props: {
      userShared: Array,
      userOndemand: Array
    },
    methods: {
        shareRequest() {
        const token = sessionStorage.getItem('token')
        const user_id = sessionStorage.getItem('userId')
        const dataShare = {searchPseudo: this.searchPseudo, user_id: user_id}
          fetch("http://localhost:3000/api/share/searchUser", {
              method: "POST",
              headers: {
              "content-type": "application/json",
              "Authorization" : 'Bearer ' + token
              },
              body: JSON.stringify(dataShare)
          })
          .then(response => {
              if(response.ok) {
                  response.json()
                  .then(data => {
                    this.searchResults = data.message
                    /* this.$parent.reloadsearchUser += 1 */
                  })
              } else { 
                response.json()
                .then(data => {
                  console.log(data) 
                })
              }
          })
        },
        responseDemand(res, idFrom) {
          const user_id = sessionStorage.getItem('userId')
          const token = sessionStorage.getItem('token')
          const dataShare = {responseStatus: res, user_id: user_id, idFrom: idFrom}
          fetch("http://localhost:3000/api/share/responseSharing", {
              method: "PUT",
              headers: {
              "content-type": "application/json",
              "Authorization" : 'Bearer ' + token
              },
              body: JSON.stringify(dataShare)
          })
          .then(response => {
              if(response.ok) {
                  response.json()
                  .then(data => {
                    this.responseSharingResult = data.message
                    /* this.$parent.reloadsearchUser += 1 */
                  })
              } else { 
                response.json()
                .then(data => {
                  this.responseSharingResult = data.message
                })
              }
          })        
        }
    }
}
</script>
