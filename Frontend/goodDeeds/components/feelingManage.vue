<template>
        <aside class="col-12 col-xl-4 text-center aside__bloc">

            <div id="aside__selection" class="row aside__selection mt-3 mt-xl-0 mb-3 mb-xl-5 p-2 load">
                <h2 class="col-12 aside__bloc--title mb-4">Sélectionne une émotion</h2>              

                <div class="col-6">

                    <b-button v-b-modal.modal-positif class="mb-3 button__feel button__feel--colorlight">Positive</b-button>

                    <b-modal id="modal-positif" title="Liste émotions positives" size="lg">
                      <b-form-row>
                          <b-col cols="6" lg="3" v-for="item in emotionsList.positive" :key="item" >
                              <label :for="item" class="label__display">{{upperFirstLetter(item)}}
                                    <input type="radio" :value="upperFirstLetter(item)" :id="item" name="emotion" v-model="feeling" @click="positiveSelect">
                                    <span class="checkmark"><fa icon="check" /></span>
                              </label>
                          </b-col>
                      </b-form-row>
                    </b-modal>
                </div>

                <div class="col-6">

                    <b-button v-b-modal.modal-negatif class="mb-3 button__feel button__feel--colordark" >Negative</b-button>

                    <b-modal id="modal-negatif" title="Liste émotions négatives" size="lg">
                      <b-form-row>
                          <b-col cols="6" lg="3" v-for="item in emotionsList.negative" :key="item" >
                                <label class="label__display" :for="item">{{upperFirstLetter(item)}}
                                    <input type="radio" :value="upperFirstLetter(item)" :id="item" name="emotion" v-model="feeling" @click="negativeSelect">
                                    <span class="checkmark"><fa icon="check" /></span>
                                </label>
                          </b-col>
                      </b-form-row>
                    </b-modal>
                </div>
            
                <div class="col-12 text-center" v-show="feeling">
                    <p class="mb-4 feeling__selected">{{feeling}}</p>
                    <button id="btn-validate" class="btn btn-primary" @click="postFeeling(feeling, kindOfFeel)">Valider</button> 
                    <button class="btn btn-warning" @click="cancelFeeling">Annuler</button> 
                </div>
            </div>
            
            <div id="aside__legend" class="row aside__legend p-2 load">
                <h2 class="aside__bloc--title col-12 mb-5">Catégories d'émotions</h2>

                <div class="d-flex flex-wrap justify-content-around col-6 col-sm-4 col-xl-6 mb-3 legend" v-for="item in emotionsList.main" :key="item.feel">
                    <div>
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
                    </div>

                    <p class="col-12 mt-n3">{{upperFirstLetter(item.feel)}}</p>
                </div>
            </div>

        </aside>

</template>

<script>
import emotions from '@/store/emotions'
import { upperFirstLetter, postFeeling } from '@/store/functions'

export default {
    data() {
        return {
            feeling: undefined,
            emotionsList : emotions,
            kindOfFeel: String, /* envoie dans le bon tableau coté mysql */
        }
    },
    
    mounted() {

        /* APPEARS ELEMENT WITH DELAY */
        setTimeout(function() {
            const eltSelection = document.getElementById('aside__selection')
            eltSelection.classList.add('reveal-1')
            const eltLegend = document.getElementById('aside__legend')
            eltLegend.classList.add('reveal-2')
        }, 500)

        /* TIMER DISABLE VALIDATE EVERY 6H */
        let dateNow = Math.round(Date.now() / 1000)
        let lastValidation = localStorage.getItem('lastValidation')
        
        if((dateNow - lastValidation) < 10 ) {
            /* 6h = 21600s */
            const boutonValidate = document.getElementById('btn-validate')
            boutonValidate.setAttribute("disabled", "")
        } 
    },
    
    methods: {
        postFeeling, 
        /* SEND TO THE RIGHT ROUTE DB */
        positiveSelect() {
            this.kindOfFeel = 'positive'
            this.$bvModal.hide('modal-1')
        },
        negativeSelect() {
            this.kindOfFeel = 'negative'
            this.$bvModal.hide('modal-2')
        },
        cancelFeeling() {
            this.feeling = undefined
        },
        upperFirstLetter
    },
}
</script>

