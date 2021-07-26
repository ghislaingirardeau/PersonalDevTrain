<template>
        <aside class="col-6 align-items-center">

            <div class="col-12 text-center">
                <h2 >Sélectionne une émotion :</h2> 
                
            </div>
            

            <div class="col-12 text-center">

                <b-button v-b-modal.modal-1 class="mb-3">Positive</b-button>

                <b-modal id="modal-1" title="Liste émotions positives">
                  <b-form-row>
                      <b-col cols="4" v-for="item in emotionsList.positive" :key="item" >
                          <input type="radio" :value="item" :id="item" name="emotion" v-model="feeling" @click="positiveSelect">
                          <label :for="item" class="radio">{{item}}</label>
                      </b-col>
                  </b-form-row>
                </b-modal>
            </div>

            <div class="col-12 text-center">
                
                <b-button v-b-modal.modal-2 class="mb-3">Negative</b-button>
        
                <b-modal id="modal-2" title="Liste émotions négatives">
                  <b-form-row>
                      <b-col cols="4" v-for="item in emotionsList.negative" :key="item" >
                          <input type="radio" :value="item" :id="item" name="emotion" v-model="feeling" @click="negativeSelect">
                          <label :for="item">{{item}}</label>
                      </b-col>
                  </b-form-row>
                </b-modal>
            </div>

            
            <div class="text-center">
                <p>{{feeling}}</p>
                <button class="btn btn-primary" v-show="feeling" @click="postFeeling">valider</button> 
            </div>

        </aside>

</template>

<script>
import emotions from '@/store/emotions'

export default {
    data() {
        return {
            feeling: undefined,
            emotionsList : emotions,
            kindOfFeel: String /* envoie dans le bon tableau coté mysql */
        }
    },
    mounted() {
 
    },
    
    methods: {
        postFeeling() {
            if(this.feeling != undefined) {
                let user_id = sessionStorage.getItem('userId')
                let token = sessionStorage.getItem('token')
                /* creer objet a envoyer */
                let postEmotion = {user_id: user_id, feeling: this.feeling}

                /* route qui varie suivant le type d'emotion pour avoir 2 tableau distinct coté sql */
                fetch(`http://localhost:3000/api/feeling/${this.kindOfFeel}`, {
                    method: "POST",
                        headers: {
                        "content-type": "application/json",
                        "Authorization" : 'Bearer ' + token
                        },
                    body: JSON.stringify(postEmotion)
                })
                .then(response => {
                    if(response.ok){
                        response.json()
                        .then(data => {
                            console.log(data)
                        })
                    } else {
                        response.json()
                        .then(data => {
                            console.log(data)
                        })
                    }
                })
                /* envoie la nouvelle emotion dans le tableau arbre et reload le composant */
                this.$parent.emotion.push(this.feeling)
                this.$parent.reload = !this.$parent.reload
            } else {
                console.log('selectionner une emotion')
            }
        },
        positiveSelect() {
            this.kindOfFeel = 'positive'
        },
        negativeSelect() {
            this.kindOfFeel = 'negative'
        }
    }
}
</script>

<style>
.radio{
    position: relative;
}
.radio::before{
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
}

input:checked{
    border: 3px solid red;
}
.radio--diplay{
   
}
.radio__container{
    border: 2px solid green;
}
</style>