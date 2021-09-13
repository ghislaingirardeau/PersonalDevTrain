<template>
    <div>
    <h1>test audio</h1>
    <button @click="testAudio" :key="mute">Oscillateur</button>
    <button @click="micro">test audio</button>
    <button @click="changeText">{{isPlaying ? 'Play' : 'Stop'}}</button>
    </div>
</template>

<script>
export default {
    data() {
        return {
            mute: false,
            frequence: 100,
            isPlaying: false
        }
    },
    methods: {
        testAudio() { /* creer un son a partir d'un oscillateur */
            this.mute = !this.mute
            var volume
            var analyser;
            
            this.frequence = this.frequence + 100
            var audioCtx = new (window.AudioContext || window.webkitAudioContext)();
            
            // create Oscillator node
            var oscillator = audioCtx.createOscillator();
            analyser = audioCtx.createAnalyser();

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
            oscillator.frequency.setValueAtTime(600, audioCtx.currentTime); // value in hertz
            oscillator.connect(gainNode);
            gainNode.connect(analyser);
            analyser.connect(audioCtx.destination);
            oscillator.start();
                setInterval(function(){
                    var FFTData = new Float32Array(analyser.frequencyBinCount);
                    analyser.getFloatFrequencyData(FFTData);
                    console.log(FFTData[0]);
                },1000);

        },
        micro() {
            this.mute = !this.mute
            var analyser;
            navigator.mediaDevices.getUserMedia ({audio: true})
            .then(function (stream) {
                var audioCtx = new AudioContext(); /* new context audio */
                analyser = audioCtx.createAnalyser(); /* creation de l'analyseur de frequence */
                var source = audioCtx.createMediaStreamSource(stream); /* je créée un nouveau stream */
                source.connect(analyser);
                analyser.connect(audioCtx.destination) /* Envoie le stream dans le haut parleur */
                setInterval(function(){
                    var FFTData = new Float32Array(analyser.frequencyBinCount);
                    analyser.getFloatFrequencyData(FFTData);
                    console.log(FFTData[0]);
                },1000);
            })
        },
        changeText() {
            var vm = this
            vm.isPlaying = !vm.isPlaying
        }
    }
}
</script>