<template>
  <section class="col-12 row my-3 justify-content-around text-center" >

    <!-- block de recherche puis demande de partage -->
    <div class="col-6">
      <div class="input-group">
        <label for="searchPseudo"></label>
        <input type="text" for="searchPseudo" v-model="searchPseudo" class="form-control" placeholder="Taper son pseudo ici" aria-label="Taper son pseudo ici">
        <div class="input-group-append">
          <button class="btn btn-primary" @click="shareRequest">Share</button>
        </div>
      </div>
    </div>

    <!-- modal affichage des personnes avec qui user est connecté ainsi que les demandes en cours -->  
    <div class="col-6 row justify-content-around">
      <b-button v-b-modal.modal-share variant="warning">Mes relations <span class="badge badge-light">{{userShared.length}}</span></b-button>
      <b-modal id="modal-share" title="Liste des personnes suivies">
        <div v-for="user in userShared" :key="user.connectTo">
          <p v-if="user.status === 'authorized'">
            <NuxtLink :to="{ name: 'share-userId', params: {id: user.connectTo}}">{{upperFirstLetter(user.pseudo)}}</NuxtLink>
          </p>
          <div v-if="user.status === 'on demand'">
            <h3 >Mes demandes en cours </h3>
            <h4>{{upperFirstLetter(user.pseudo)}}</h4>
          </div>
        </div>      
      </b-modal>      

      <!-- modal affichage des demandes de partage : si rejet ou autorisation du partage -->
      <b-button v-b-modal.modal-demand variant="info">Demande de partage <span class="badge badge-light">{{userOndemand.length}}</span></b-button>
      <b-modal id="modal-demand" title="Mes demandes à valider">
        <div v-for="user in userOndemand" :key="user.connectfrom" class="mb-4">
          <p class="col-12">{{upperFirstLetter(user.pseudo)}} souhaite partager son arbre avec vous</p>
          <div class="col-12 d-inline">
            <button @click="responseDemand('authorized', user.connectfrom)" class="btn btn-outline-success">Accepter</button>
            <!-- Si autorisation renvoie aussi une autorisation d'acces pour l'autre utilisateur -->
            <button @click="responseDemand('rejected', user.connectfrom)" class="btn btn-outline-danger">Refuser</button>
          </div>
        </div>
        <strong>{{responseSharingResult}}</strong>
      </b-modal>
    </div>

    <!-- La réponse de la recherche si succes ou non -->
    <p v-if="searchResults" class="mt-2 text-left col-12">{{searchResults}}</p>  

  </section>

</template>

<script>
import { upperFirstLetter } from '@/store/functions'

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
      upperFirstLetter,
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
                  })
              } else { 
                response.json()
                .then(data => {
                  this.responseSharingResult = data.message
                })
              }
          })   
          this.$bvModal.hide('modal-demand')     
        }
    }
}
</script>
