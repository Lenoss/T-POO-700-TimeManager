<template>
  <div class="row">
    <div class="col-md-4">
      <user-card :user="user"></user-card>
      <user-report-card
        :user="user"
        @clockIn="clockIn"
        @newWorkingTime="newWorkingTime"
      ></user-report-card>
    </div>
    <div class="col-md-8">
      <edit-profile-form
        :user="user"
        @editUser="editUser"
        @deleteUser="deleteUser"
      >
      </edit-profile-form>
    </div>
  </div>
</template>
<script>
import EditProfileForm from "./Profile/EditProfileForm";
import UserCard from "./Profile/UserCard";
import UserReportCard from "./Profile/UserReportCard";
import authHeader from "../services/auth-header";

import axios from "axios";

const apiEndPoint = process.env.VUE_APP_API_ENDPOINT;
export default {
  components: {
    EditProfileForm,
    UserCard,
    UserReportCard,
  },
  computed: {
    currentUser() {
      return this.$store.state.auth.user;
    },
  },
  data() {
    return {
      model: {},
      user: {},
    };
  },
  mounted() {
    if (!this.currentUser) {
      this.$router.push("/login");
    }
  },
  created() {
    axios
      .get(`${apiEndPoint}/users/${this.currentUser.user_id}`, authHeader())
      .then((response) => {
        // JSON responses are automatically parsed.

        this.user = response.data.data;
        console.log(this.user);
      })
      .catch((e) => {
        this.errors.push(e);
      });
  },
  methods: {
    editUser: function () {
      console.log(this.user);
      let objectUser = {
        user: this.user,
      };
      delete objectUser.user.id;
      axios
        .put(`${apiEndPoint}/users/${this.currentUser.user_id}`, objectUser, authHeader())
        .then((response) => {
          alert("Profile edited");
        })
        .catch((e) => {
          this.errors.push(e);
        });
    },
    clockIn: function (event) {
      if (event.Arrived) {
        let clock = {
          status: true,
          time: new Date().toJSON(),
        };
        let objectClock = {
          clocks: clock,
        };
        axios
          .post(`${apiEndPoint}/clocks/${this.currentUser.user_id}`, objectClock, authHeader())
          .then((response) => {
            alert("Clocked in");
          })
          .catch((e) => {
            this.errors.push(e);
          });
      } else {
        let clock = {
          status: false,
          time: new Date().toJSON(),
        };
        let objectClock = {
          clocks: clock,
        };
        axios
          .post(`${apiEndPoint}/clocks/${this.currentUser.user_id}`, objectClock, authHeader())
          .then((response) => {
            alert("Clocked in");
          })
          .catch((e) => {
            this.errors.push(e);
          });
      }
    },
    newWorkingTime: function (schedule) {
      let workingtime = {
        start: schedule[0],
        end: schedule[1],
      };
      let objectWorkingTime = {
        workingtimes: workingtime,
      };
      axios
        .post(`${apiEndPoint}/workingtimes/${this.currentUser.user_id}`, objectWorkingTime, authHeader())
        .then((response) => {
          console.log("new schedule added");
        })
        .catch((e) => {
          this.errors.push(e);
        });
    },
    deleteUser: function () {
      if (
        confirm(
          "You are going to definetely delete your account, do you want to continue?"
        )
      ) {
        axios
          .delete(`${apiEndPoint}/users/${this.currentUser.user_id}`)
          .then((response) => {
            alert("User deleted");
          })
          .catch((e) => {
            this.errors.push(e);
          });
      }
    },
  },
};
</script>
<style>
</style>
