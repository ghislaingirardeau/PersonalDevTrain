<template>
    <main>
        <h1>Comment allez vous aujourd'hui</h1>
        
        <input type="radio" value="happy" id="happy" name="emotion" v-model="postEmotion.feeling">
        <label for="happy">happy</label>
        <button @click="postFeeling">valider</button>
        
    </main>
</template>

<script>
export default {
    data() {
        return {
            postEmotion: {
                feeling: undefined,
                userId: Number
            }
        }
    },
    methods: {
        postFeeling() {
            if(this.postEmotion.feeling != undefined) {
            this.postEmotion.userId = sessionStorage.getItem('userId')

            fetch("http://localhost:3000/api/feeling/positive", {
            method: "POST",
                headers: {
                "content-type": "application/json",
                },
            body: JSON.stringify(this.postEmotion)
            })
            .then(response => {
                if(response.ok){
                    response.json()
                    .then(data => {
                        console.log(data)
                    })
                }
            })

            } else {
                console.log('select one')
            }
        }
    }
}
</script>