<script>
import { ethers } from "ethers";


export default {
  props: {
    img: {
      type: String,
      default: "",
      required: true,
    },
    name: {
      type: String,
      default: "",
      required: true,
    },
    description: {
      type: String,
      default: "",
    },
    id: {
      type: [String, Number],
      default: null,
    },
    price: {
      type: Number,
      default: 0,
      required: true,
    },
    time: {
      type: [String, Number],
      default: "",
    },
    autor: {
      type: String,
      default: "",
    },
    avatar: {
      type: String,
      default: "",
    },
  },
  data() {
    return {
      verificationMap: [
        {
          style: "color: gray",
          status: "Unverified",
        },
        {
          style: "color: green",
          status: "You own this NFT",
        },
        {
          style: "color: red",
          status: "You do not own this NFT",
        },
        {
          style: "color: red",
          status: "Address cannot be empty",
        },
      ],
      status : null,
      style: null,
      // verification: this.verificationMap[0],
      walletAddress: "",
    };
  },
  beforeMount(){
    this.update(0)
  },
  methods: {
    async verify() {
      if (this.walletAddress == "") {
        this.update(3)
        return;
      }
      let res = await fetch(
        `https://nft.tafhub.org/verify?&address=${this.walletAddress}`
      ).catch(()=>{
        this.update(2)
        console.log(this.status)
      }
        )
      if (res.status == 200) {
        this.update(1)
        console.log(this.status)
      } else {
        this.update(2)
        console.log(this.status)
      }
    },
    update(x){
      this.status = this.verificationMap[x]
      console.log(this.status)
    },
    async inject() {
      let provider;
      try {
        provider = new ethers.providers.Web3Provider(window.ethereum);
        await provider.send("eth_requestAccounts", []);
        this.walletAddress = await provider.getSigner().getAddress();
        console.log(this.walletAddress)
      } catch (e) {
        console.log("metamask is not installed", e);
      }

      console.log(this.walletAddress);
    },
  },
};
</script>

<template>
  <div class="card">
    <div class="card__product-img">
      <img
        class="card__img"
        alt="product-image"
        :src="require('@/static/images/' + img)"
      />
    </div>
    <div class="card__content">
      <p class="card__name">
        {{ name }} <span v-if="id">#{{ id }}</span>
      </p>
      <p class="card__description" v-if="description">{{ description }}</p>
      <div class="card__content-bottom">
        <div class="card__price">
          <div class="icon">
            <img src="@/assets/images/nft-card/icon-ethereum.svg" alt="" />
          </div>
          <p>{{ price }} ETH</p>
        </div>
        <div v-if="time" class="card__time">
          <div class="icon">
            <img src="@/assets/images/nft-card/icon-clock.svg" alt="" />
          </div>
          <p>Does not expire</p>
        </div>
      </div>
    </div>
    <div class="card__footer" style="height: 6rem">
      <b-row style="width: 100%; margin: 0">
        <b-col cols="3">
          <b-button
            @click="verify"
            type="button"
            class="btn btn-secondary"
            size="lg"
            style="height: 100%"
            >Verify
          </b-button>
        </b-col>
        <b-col cols="9">
          <b-input-group class="verify">
            <template #append>
              <b-input-group-text
                @click="inject"
                v-b-tooltip.hover
                title="Inject address via metamask"
              >
                <img
                  src="https://img.icons8.com/color/20/000000/metamask-logo.png"
                />
              </b-input-group-text>
            </template>
            <b-form-input
              placeholder="Address"
              type="text"
              size="lg"
              :value="walletAddress"
              v-model="walletAddress"
            >
            </b-form-input>
          </b-input-group>
        </b-col>
      </b-row>
    </div>
    <div class="card__footer" style="height: 2rem; margin-top: 2rem">
      <span :style="status.style">{{ status.status }}</span>
    </div>
  </div>
</template>

<style scoped lang="scss">
.icon {
  display: flex;
}

.verify {
  height: 100%;
}

.card {
  background-color: #15263f;
  color: #8bacd9;
  border-radius: 16px;
  padding: 24px;
  width: 327px;
  font-size: 1.5rem;
  box-shadow: 0 25px 50px 0 rgba(0, 0, 0, 0.1);
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
        color: #00fff8;
      }
    }
  }
  .card__footer {
    display: flex;
    align-items: center;
    border-top: 1px solid #2e405a;
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
