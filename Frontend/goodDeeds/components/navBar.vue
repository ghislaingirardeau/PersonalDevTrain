<template>
    <header>

        <nav>
            <button @click="Show">Se connecter</button>
            <button @click="Show">S'inscrire</button>
        </nav>
    </header>
</template>

<script>
export default {
    data() {
        return {

        }
    },
    props: {
        login: Boolean,
        signup: Boolean
    },
    methods: {
        Show() {
            this.login = !this.login
            this.signup = !this.signup
        }
    }
}
</script>