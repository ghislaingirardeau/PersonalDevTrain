<template>
    <article class="col-12 col-xl-7">
      <h2>sharing Tree</h2>
      <label for="searchPseudo"></label>
      <input type="text" for="searchPseudo" v-model="searchPseudo" > 
      <button @click="shareRequest">Demande de partage</button>
      <p>{{searchResults}}</p>
      
      <h3>Mes personnes suivies</h3>
      <div v-for="user in userShared" :key="user.connectTo">
        <h2 v-if="user.status === 'authorized'">acces autorisé: {{user.pseudo}}</h2>
        <div v-if="user.status === 'on demand'">
          <h2>mes demandes en attente : {{user.pseudo}}</h2>
        </div>
      </div>

      <h2>Demande de suivi en attente</h2>
      <div v-for="user in userOndemand" :key="user.connectFrom">
        <p>demande de {{user.pseudo}}</p>
        <button>accepter</button>
      </div>
    </article>

</template>

<script>
export default {
    data() {
        return{
          searchPseudo: '',
          searchResults: String
        }
    },
    props: {
      userShared: Array,
      userOndemand: Array
    },
    methods: {
        shareRequest() {
        let token = sessionStorage.getItem('token')
        let user_id = sessionStorage.getItem('userId')
        let dataShare = {searchPseudo: this.searchPseudo, user_id: user_id}
            fetch("http://localhost:3000/api/feeling/searchUser", {
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
                                   
                    })
                } else { 
                  response.json()
                  .then(data => {
                    console.log(data) 
                  })
                }
            })
        }

    }
}
</script>
