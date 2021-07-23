<template>
    <main>
        <h2>Ton émotion</h2>
        
        <ul v-for="item in emotionsList.list" :key="item" >
            <li>
                <input type="radio" :value="item" :id="item" name="emotion" v-model="postEmotion.feeling">
                <label :for="item">{{item}}</label>
            </li>
        </ul>
        
        <button @click="postFeeling">valider</button>
        
    </main>
</template>

<script>
import emotions from '@/store/emotions'

export default {
    data() {
        return {
            postEmotion: {
                feeling: undefined,
                user_id: Number
            },
            emotionsList : emotions
        }
    },
    
    methods: {
        postFeeling() {
            if(this.postEmotion.feeling != undefined) {
                this.postEmotion.user_id = sessionStorage.getItem('userId')
                let token = sessionStorage.getItem('token')

                fetch("http://localhost:3000/api/feeling/positive", {
                    method: "POST",
                        headers: {
                        "content-type": "application/json",
                        "Authorization" : 'Bearer ' + token
                        },
                    body: JSON.stringify(this.postEmotion)
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
                this.$parent.emotion.push(this.postEmotion.feeling)
                this.$parent.reload = !this.$parent.reload
            } else {
                console.log('select one')
            }
        }
    }
}
</script>