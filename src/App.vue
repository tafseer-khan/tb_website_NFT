<template>
  <NFTCard 
    :img="card.img" 
    :name="card.name"
    :id="card.id"
    :description="card.description"
    :price="card.price"
    :time="card.time"
    :autor="card.autor"
    :avatar="card.avatar"
    :verification="card.verification"
  />
</template>

<script>
import NFTCard from './components/NFTCard/NFTCard.vue'

export default {
  name: 'App',
  components: {
    NFTCard
  },
  data: () => ({
    card: {
      img: 'taubyte.png',
      name: 'Taubyte',
      description: 'Taubyte collection used for verifying grandfather status.',
      price: 0.00,
      time: 2,
    }
  })
}
</script>
<style lang="scss">

@import url('https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600&display=swap');

* {
  margin: 0;
  box-sizing: border-box;
}
html {
  font-size: 62.5%;
}
img {
  width: 100%;
  vertical-align: middle;
}
body {
  background-color: #0D192C!important;
  font-family: 'Outfit', sans-serif;
}
#app {
  display: flex;
  justify-content: center;
  margin-top: 62px;
  @media screen and (min-width: 768px) {
      margin-top: 152px;
  }
}
</style>
