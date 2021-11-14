<template>
  <card class="w-50">
    <h5 slot="header" class="title">Register Account</h5>
    <div class="row">
      <!-- <div class="col-md-6 pr-md-1">
        <base-input
          label="Username"
          placeholder="Username"
          v-model="user.username"
        >
        </base-input>
      </div> -->
      <div class="col-md-6 pr-md-1">
        <base-input
          label="Email address"
          type="email"
          v-model="user.email"
          placeholder="mike@email.com"
        >
        </base-input>
      </div>
      <div class="col-md-6 pr-md-1">
        <base-input
          label="Password"
          type="password"
          v-model="user.password"
          placeholder="Enter password"
        >
        </base-input>
      </div>
    </div>
    <div class="row">
      <div class="col-md-6 pr-md-1">
        <base-input
          label="First Name"
          v-model="user.firstname"
          placeholder="First Name"
        >
        </base-input>
      </div>
      <div class="col-md-6 pl-md-1">
        <base-input
          label="Last Name"
          v-model="user.lastname"
          placeholder="Last Name"
        >
        </base-input>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">
        <base-input
          label="Address"
          v-model="user.address"
          placeholder="Home Address"
        >
        </base-input>
      </div>
    </div>
    <div class="row">
      <div class="col-md-4 pr-md-1">
        <base-input label="City" v-model="user.city" placeholder="City">
        </base-input>
      </div>
      <div class="col-md-4 px-md-1">
        <base-input
          label="Country"
          v-model="user.country"
          placeholder="Country"
        >
        </base-input>
      </div>
      <div class="col-md-4 pl-md-1">
        <base-input
          label="Postal Code"
          placeholder="ZIP Code"
          v-model="user.zipcode"
        >
        </base-input>
      </div>
    </div>

    <div class="d-flex justify-content-between">
      <base-button slot="footer" type="primary" fill v-on:click="register"
        >Register</base-button
      >
    </div>
  </card>
</template>

<script>
import User from "../models/user";
import axios from "axios";

const apiEndPoint = process.env.VUE_APP_API_ENDPOINT;

export default {
  name: "Signup",
  data() {
    return {
      user: new User("", ""),
      loading: false,
      message: "",
    };
  },
  computed: {
    loggedIn() {},
  },
  created() {
    if (this.loggedIn) {
    }
  },
  methods: {
    register: function () {
      this.user.role = "Member";
      let objectUser = {
        user: this.user,
      };
      axios
        .post(`${apiEndPoint}/users`, objectUser)
        .then((response) => {
          console.log(this.response);
        })
        .catch((e) => {
          this.errors.push(e);
        });
    },
  },
};
</script>

<style scoped>
label {
  display: block;
  margin-top: 10px;
}

.card-container.card {
  max-width: 350px !important;
  padding: 40px 40px;
}

.card {
  padding: 20px 25px 30px;
  margin: 0 auto 25px;
  margin-top: 50px;
  -moz-border-radius: 2px;
  -webkit-border-radius: 2px;
  border-radius: 2px;
  -moz-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
  -webkit-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
  box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
}
</style>
