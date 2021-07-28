<template>
        <aside class="col-4 align-items-center">

            <div class="col-12 text-center">
                <h2 class="mb-5">Sélectionne une émotion :</h2>              
            </div>
            

            <div class="col-12 text-center">

                <b-button v-b-modal.modal-1 class="mb-3">Positive</b-button>

                <b-modal id="modal-1" title="Liste émotions positives">
                  <b-form-row>
                      <b-col cols="4" v-for="item in emotionsList.positive" :key="item" >
                          <label :for="item" class="label__display">{{item}}
                                <input type="radio" :value="item" :id="item" name="emotion" v-model="feeling" @click="positiveSelect">
                                <span class="checkmark"><fa icon="check" /></span>
                          </label>
                      </b-col>
                  </b-form-row>
                </b-modal>
            </div>

            <div class="col-12 text-center">
                
                <b-button v-b-modal.modal-2 class="mb-3">Negative</b-button>
        
                <b-modal id="modal-2" title="Liste émotions négatives">
                  <b-form-row>
                      <b-col cols="4" v-for="item in emotionsList.negative" :key="item" >
                            <label class="label__display" :for="item">{{item}}
                                <input type="radio" :value="item" :id="item" name="emotion" v-model="feeling" @click="negativeSelect">
                                <span class="checkmark"><fa icon="check" /></span>
                            </label>
                      </b-col>
                  </b-form-row>
                </b-modal>
            </div>

            
            <div class="text-center">
                <p class="feeling__selected">{{feeling}}</p>
                <button class="btn btn-primary" v-show="feeling" @click="postFeeling">Valider</button> 
            </div>

            <h2 class="mb-5">Légende, catégorie des émotions</h2>

            <div class="d-flex legend" v-for="item in emotionsList.main" :key="item.feel">
                <svg wclassth="30" height="30" viewBox="595 0 50 50" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <g>
                        <path  d="M611 2.00002C608.9 5.90002 608.6 14.4 610.4 19.7C613 27.7 621.7 35 629.9 36.2C631.9 36.4 632.5 35.9 633.6 33C638.5 19.5 629.5 3.50002 615.3 0.500021C612.7 2.08223e-05 611.9 0.300021 611 2.00002Z" :fill="item.colorPrimary"/>
                    </g>
                </svg>
                <svg wclassth="30" height="30" viewBox="595 0 50 50" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <g>
                        <path  d="M611 2.00002C608.9 5.90002 608.6 14.4 610.4 19.7C613 27.7 621.7 35 629.9 36.2C631.9 36.4 632.5 35.9 633.6 33C638.5 19.5 629.5 3.50002 615.3 0.500021C612.7 2.08223e-05 611.9 0.300021 611 2.00002Z" :fill="item.colorSecondary"/>
                    </g>
                </svg>
                <svg wclassth="30" height="30" viewBox="595 0 50 50" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <g>
                        <path  d="M611 2.00002C608.9 5.90002 608.6 14.4 610.4 19.7C613 27.7 621.7 35 629.9 36.2C631.9 36.4 632.5 35.9 633.6 33C638.5 19.5 629.5 3.50002 615.3 0.500021C612.7 2.08223e-05 611.9 0.300021 611 2.00002Z" :fill="item.colorThird"/>
                    </g>
                </svg>
                <p>{{item.feel}}</p>
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
            kindOfFeel: String, /* envoie dans le bon tableau coté mysql */
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

</style>