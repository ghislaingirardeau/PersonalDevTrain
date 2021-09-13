<template>
    <div>
    <h1>test audio</h1>
    <button @click="testAudio" :key="mute">test</button>
    </div>
</template>

<script>
export default {
    data() {
        return {
            mute: false,
            frequence: 100
        }
    },
    methods: {
        testAudio() { /* creer un son a partir d'un oscillateur */
            this.mute = !this.mute
            var volume
            
            this.frequence = this.frequence + 100
            var audioCtx = new (window.AudioContext || window.webkitAudioContext)();
            
            // create Oscillator node
            var oscillator = audioCtx.createOscillator();

            var gainNode = audioCtx.createGain();
            if(this.mute == false) {
                volume = 0
            } else {
                volume = 1
            }
            console.log(volume)
            gainNode.gain.value = volume
            console.log(gainNode.gain)

            oscillator.type = 'square';
            oscillator.frequency.setValueAtTime(this.frequence, audioCtx.currentTime); // value in hertz
            oscillator.connect(gainNode);
            gainNode.connect(audioCtx.destination);
            oscillator.start();
            console.log(oscillator)
        },        
    }
}
</script>