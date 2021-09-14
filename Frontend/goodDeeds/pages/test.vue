<template>
    <div>
    <h1>test audio</h1>
    <label for="">frequence</label>
    <input type="range" min="0" max ="1600" step="20" v-model="frequence" @change="testAudio"> {{frequence}}
    <select id="type" v-model="oscillatorType">
        <option value="sine">sine</option>
        <option value="square">square</option>
        <option value="sawtooth">sawtooth</option>
        <option value="triangle">triangle</option>
    </select>
    <button @click="testAudio">{{!mute ? 'Play' : 'Stop'}}</button>
    <button @click="micro">{{!mute ? 'Start' : 'Stop'}}</button>
    <p>{{frequenceResults}}</p>
    <h2>change frequence avec la souris</h2>
    <p @mousemove="updateCoordonate" class="border p-3"></p>
    </div>
</template>

<script>
export default {
    data() {
        return {
            mute: false,
            frequence: 440,
            oscillator: 0,
            source: 0,
            analyser: 0,
            audioCtx: 0,
            interval: 0,
            fftData: 0,
            oscillatorType: "sine",
        }
    },
    computed: {
        frequenceResults() {
            if(this.fftData < -125) {
                    return "ok" + this.fftData
                } else if(this.fftData === 0) {
                    return "en attente de fréquence"
                } else {
                    return "mauvaise"
                }
        },
    },
    methods: {
        testAudio() { /* creer un son a partir d'un oscillateur */
            this.mute = !this.mute
            var vm = this
            
            var gainNode
            if(this.mute == false) {
                vm.oscillator.stop();
                clearInterval(vm.interval)
            } else {
                var audioCtx = new (window.AudioContext || window.webkitAudioContext)();
                vm.analyser = audioCtx.createAnalyser();
                vm.oscillator = audioCtx.createOscillator();
                gainNode = audioCtx.createGain();
                vm.oscillator.type = vm.oscillatorType;
                vm.oscillator.frequency.value = vm.frequence; // value in hertz
                vm.oscillator.connect(vm.analyser);
                vm.analyser.connect(gainNode);
                gainNode.connect(audioCtx.destination);
                vm.oscillator.start();
                vm.interval = setInterval(function(){
                        var FFTData = new Float32Array(1024);
                        vm.analyser.getFloatFrequencyData(FFTData);
                        vm.fftData = FFTData[0]
                    },1000);

            }


        },
        micro() {
            this.mute = !this.mute
            var vm = this

            if (this.mute == false) {
                /* vm.source.disconnect(vm.analyser);
                vm.analyser.disconnect(vm.audioCtx.destination);
                vm.audioCtx.close() */
            } else {
                navigator.mediaDevices.getUserMedia ({audio: true})
                .then(function (stream) {
                vm.audioCtx = new AudioContext(); /* new context audio */
                vm.analyser = vm.audioCtx.createAnalyser(); /* creation de l'analyseur de frequence */
                vm.source = vm.audioCtx.createMediaStreamSource(stream); /* je créée un nouveau stream */
                vm.source.connect(vm.analyser);
                vm.analyser.connect(vm.audioCtx.destination) /* Envoie le stream dans le haut parleur */
                    setInterval(function(){
                        var FFTData = new Float32Array(1024);
                        vm.analyser.getFloatFrequencyData(FFTData);
                        console.log(vm.analyser.fftSize);
                    },1000);
                })

            }
            
        },
        updateCoordonate(e) {
            var vm = this
            this.frequence = e.pageX
            vm.oscillator.frequency.value = e.pageX
        }
    }
}
</script>