<template>
  <card>
    <h5 slot="header" class="title">Edit Profile</h5>
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
    <!-- <div class="row">
      <div class="col-md-8">
        <base-input>
          <label>About Me</label>
          <textarea rows="4" cols="80"
                    class="form-control"
                    placeholder="Here can be your description"
                    v-model="model.about">

              </textarea>
        </base-input>
      </div>
    </div> -->
    <div class="d-flex justify-content-between">
      <base-button slot="footer" type="primary" fill v-on:click="sendEdit"
        >Save</base-button
      >
      <base-button slot="footer" type="danger" fill v-on:click="sendDelete"
        >Delete</base-button
      >
    </div>
  </card>
</template>
<script>
export default {
  props: {
    user: {
      type: Object,
      default: () => {
        return {};
      },
    },
  },
  methods: {
    sendEdit: function () {
      this.$emit("editUser");
    },
        sendDelete: function () {
      this.$emit("deleteUser");
    },
  },
};
</script>
<style>
</style>
