<template>
  <div class="card" >
    <div class="card__product-img">
      <img 
        class="card__img"
        alt="product-image" 
        :src="require('@/static/images/' + img)"
      >
    </div>
    <div class="card__content">
      <p class="card__name">{{ name }} <span v-if="id">#{{ id }}</span></p>
      <p class="card__description" v-if="description">{{ description }}</p>
      <div class="card__content-bottom">
        <div class="card__price">
          <div class="icon">
            <img src="@/assets/images/nft-card/icon-ethereum.svg" alt="">
          </div>
          <p>{{ price }} ETH</p>
        </div>
        <div v-if="time" class="card__time">
          <div class="icon">
            <img src="@/assets/images/nft-card/icon-clock.svg" alt="">
          </div>
          <p>Does not expire</p>
        </div>
      </div>
    </div>
    <div class="card__footer">
          <b-button @click="requestPermission" type="button" class="btn btn-secondary" size="lg">Verify Ownership</b-button>
          <span v-if="verification == 0">Unverified</span>
          <span v-if="verification == 1">Holder owns this NFT</span>
          <span v-if="verification == 2">Holder does not own this NFT</span>
    </div>
  </div>
</template>

<script>
import { ethers } from "ethers"

export default {
  props: {
    img: {
      type: String,
      default: '',
      required: true
    },
    name: {
      type: String,
      default: '',
      required: true
    },
    description: {
      type: String,
      default: ''
    },
    id: {
      type: [String, Number],
      default: null
    },
    price: {
      type: Number,
      default: 0,
      required: true
    },
    time: {
      type: [String, Number],
      default: ''
    },
    autor: {
      type: String,
      default: ''
    },
    avatar: {
      type: String,
      default: '',
    },
  },
  data(){
    return{
      verification:0,
      provider:new ethers.providers.Web3Provider(window.ethereum)
    }
  },
  methods:{
    async requestPermission(){
      await this.provider.send("eth_requestAccounts",[])
      let walletAddress =await this.provider.getSigner().getAddress()
      console.log(walletAddress)
      let res = await fetch(`https://nft.tafhub.org/verify?&address=${walletAddress}`)
      if (res.status == 200){
        this.verification = 1
        console.log(this.verification)
      }else{
        this.verification = 2
        console.log(this.verification)
      }
      console.log(res)
    }
  },
}
</script>

<style scoped lang="scss">
.icon {
  display: flex;
}
.card {
  background-color: #15263F;
  color: #8BACD9;
  border-radius: 16px;
  padding: 24px;
  width: 327px;
  font-size: 1.5rem;
  box-shadow: 0 25px 50px 0 rgba(0,0,0,0.1);
  @media screen and (min-width: 768px) {
    font-size: 1.6rem;
    width: 350px;
    padding-bottom: 32px;
  }
  .card__product-img {
    position: relative;
    border-radius: 8px;
    overflow: hidden;
  }
  .card__content {
    display: flex;
    flex-direction: column;
    gap: 12px;
    padding: 24px 0 16px 0;
    @media screen and (min-width: 768px) {
      gap: 16px;
      padding: 24px 0;
    }
    .card__name {
      color: white;
      font-size: 2.2rem;
      font-weight: bold;
    }
    .card__description {
      font-size: 1.8rem;
      line-height: 2.6rem;
      font-weight: lighter;
    }
    .card__content-bottom {
      display: flex;
      justify-content: space-between;
      padding-top: 4px;
      @media screen and (min-width: 768px) {
        padding-top: 6px;
      }
      > * {
        display: flex;
        align-items: center;
        gap: 8px;
        font-weight: 600;
      }
      .card__price {
        color: #00FFF8;
      }
    }
  }
  .card__footer {
    display: flex;
    align-items: center;
    border-top: 1px solid #2E405A;
    gap: 16px;
    padding-top: 16px;
    .card__avatar {
      display: flex;
      border-radius: 90px;
      border: 1px solid white;
      img {
        width: 33px;
      }
    }
  }
}

//Transition
.fade-enter-active,
.fade-leave-active {
    transition: 0.25s ease-out;
}
.fade-leave-to,
.fade-enter-from {
  opacity: 0;
}
</style>
