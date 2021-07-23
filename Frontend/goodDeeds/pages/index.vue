<template>
<div>
  <h1>Mon tableau de bord émotionnel</h1>
  <h2>Mon arbre d'emotions</h2>

  <tree :getPositive="positive" :getNegative="negative" />
</div>
  
</template>

<script>
import feelings from '@/store/API'

export default {
  data () {
    return {
      positive: feelings.positive,
      negative: feelings.negative,
    }
  },


}
</script>

<style>
path[class*='Vector'] {
  /* transform-origin: center;
  transform-box: fill-box;
  animation: feuille 4s; */
  opacity: 0;
}

path[class*='appear'] {
  transform-origin: center;
  transform-box: fill-box;
  animation: feuille 4s forwards;

}

@keyframes feuille {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
  
}
</style>
