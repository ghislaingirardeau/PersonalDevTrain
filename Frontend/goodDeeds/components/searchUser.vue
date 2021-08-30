<template>
  <section class="col-12 d-flex flex-wrap text-center mb-2" >
    <!-- <button @click="updateSharing">Emit Event</button> -->
    <!-- block de recherche puis demande de partage -->
    <div class="col-12 col-lg-6 order-1 order-lg-0">
      <div class="input-group">
        <label for="searchPseudo"></label>
        <input type="text" for="searchPseudo" v-model="searchPseudo" class="form-control" placeholder="Taper son pseudo ici" aria-label="Taper son pseudo ici">
        <div class="input-group-append">
          <button class="btn btn-primary" @click="shareRequest">Rechercher et partager</button>
        </div>
      </div>
      <!-- La réponse de la recherche si succes ou non -->
      <transition name="slideY">
      <div v-if="searchResults" :key="searchResults" class="mt-2">
        <p class="text-left col-12">{{searchResults}}</p>
      </div>  
      </transition>
    </div>

    <!-- modal affichage des personnes avec qui user est connecté ainsi que les demandes en cours -->  
    <div class="col-12 col-lg-6 d-flex flex-wrap justify-content-center justify-content-lg-end order-0 order-lg-1 mb-3 mb-lg-0">
      <b-button v-b-modal.modal-share variant="warning" class="mb-2 mb-sm-0 mx-sm-2 btn--height">Mes relations <span class="badge badge-light">{{userShared.length}}</span></b-button>
      <b-modal id="modal-share" title="Liste des personnes suivies">
        <div v-for="user in userShared" :key="user.connectTo">
          <p v-if="user.status === 'authorized'">
            <NuxtLink :to="{ name: 'share-userId', params: {id: user.connectTo}}">{{upperFirstLetter(user.pseudo)}}</NuxtLink>
          </p>
          <div v-if="user.status === 'on demand'">
            <p >{{upperFirstLetter(user.pseudo)}} en cours</p>
          </div>
        </div>      
      </b-modal>      

      <!-- modal affichage des demandes de partage : si rejet ou autorisation du partage -->
      <b-button v-b-modal.modal-demand variant="info" class="mx-2 btn--height">Mes demandes <span class="badge badge-light">{{userOndemand.length}}</span></b-button>
      <b-modal id="modal-demand" title="Mes demandes à valider">
        <div v-for="user in userOndemand" :key="user.connectfrom" class="mb-4">
          <p class="col-12">{{upperFirstLetter(user.pseudo)}} souhaite partager son arbre avec vous</p>
          <div class="col-12 d-inline">
            <button @click="responseDemand('authorized', user.connectfrom, user.pseudo)" class="btn btn-outline-success">Accepter</button>
            <!-- Si autorisation renvoie aussi une autorisation d'acces pour l'autre utilisateur -->
            <button @click="responseDemand('rejected', user.connectfrom, user.pseudo)" class="btn btn-outline-danger">Refuser</button>
          </div>
        </div>
        <p v-if="userOndemand.length === 0">Aucune demande en cours</p>
        <strong>{{responseSharingResult}}</strong>
      </b-modal>
    </div>


  </section>

</template>

<script>
import { upperFirstLetter, shareRequest, responseDemand } from '@/store/functions'

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
  mounted() {
    
  },
  methods: {
    upperFirstLetter,
    shareRequest,
    responseDemand,
  }
}
</script>

<style lang="scss">
.btn--height{
  height: 40px;
}
</style>