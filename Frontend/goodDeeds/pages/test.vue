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

    <div >
        <button class="m-2" v-for="item in notes" :key="item.note" @click="frequenceNote(item.frequence)">{{item.note}}</button>
    </div>

    <h2>Modifie le volume (Y) et la frequence (X) avec la souris</h2>
    <p @mousemove="updateCoordonate" class="border p-3" id="canvas"></p>
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
            gainNode: 0,
            oscillatorType: "sine",
            notes: [{
                note: "do",
                frequence: 261},
                {
                note: "re",
                frequence: 293},
                {
                note: "mi",
                frequence: 329},
                {
                note: "fa",
                frequence: 349},
                {
                note: "sol",
                frequence: 392},
                {
                note: "la",
                frequence: 440}
                ]
        }
    },
    computed: {
        frequenceResults() {
            if(this.fftData < -125) {
                    return "ok" + this.fftData
                } else if(this.fftData === 0) {
                    return "en attente d'analyse"
                } else {
                    return "mauvaise" + this.fftData
                }
        },
    },
    methods: {
        testAudio() { /* creer un son a partir d'un oscillateur */
            this.mute = !this.mute
            var vm = this
            
            if(this.mute == false) {
                vm.oscillator.stop();
                clearInterval(vm.interval)
            } else {
                var audioCtx = new (window.AudioContext || window.webkitAudioContext)();
                vm.analyser = audioCtx.createAnalyser();
                vm.oscillator = audioCtx.createOscillator();
                vm.gainNode = audioCtx.createGain();
                vm.oscillator.type = vm.oscillatorType;
                vm.oscillator.frequency.value = vm.frequence; // value in hertz
                vm.oscillator.connect(vm.analyser);
                vm.analyser.connect(vm.gainNode);
                vm.gainNode.connect(audioCtx.destination);
                vm.oscillator.start();
                vm.interval = setInterval(function(){
                        var FFTData = new Float32Array(1024);
                        vm.analyser.getFloatFrequencyData(FFTData);
                        vm.fftData = FFTData[0]
                    },100);

            }
        },
        micro() {
            this.mute = !this.mute
            var vm = this

            if (this.mute == false) {
                vm.source.disconnect(vm.analyser);
                vm.analyser.disconnect(vm.audioCtx.destination);
                vm.audioCtx.close()
                clearInterval(vm.interval)
                vm.source = 0
            } else {
                navigator.mediaDevices.getUserMedia ({audio: true})
                .then(function (stream) {
                vm.audioCtx = new AudioContext(); /* new context audio */
                vm.analyser = vm.audioCtx.createAnalyser(); /* creation de l'analyseur de frequence */
                vm.source = vm.audioCtx.createMediaStreamSource(stream); /* je créée un nouveau stream */
                vm.source.connect(vm.analyser);
                vm.analyser.connect(vm.audioCtx.destination) /* Envoie le stream dans le haut parleur */
                vm.interval = setInterval(function(){
                        var FFTData = new Float32Array(1024);
                        vm.analyser.getFloatFrequencyData(FFTData);
                        console.log(FFTData[0]);
                    },1000);
                })
            }
        },
        updateCoordonate(e) {
            var vm = this
            if(vm.gainNode != 0) {
                vm.gainNode.gain.value = e.pageX /1000
            }
            if(vm.oscillator != 0) {
                vm.oscillator.frequency.value = e.pageY * 1.5
            }
        },
        frequenceNote(note) {
            var vm = this
            vm.oscillator.frequency.value = note
            }
    }
}
</script>

<style lang="scss">
#canvas{
    background: linear-gradient(to right, white, grey);
    height: 400px;
    }
</style>