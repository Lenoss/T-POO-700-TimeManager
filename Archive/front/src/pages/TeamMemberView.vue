<template>
  <div>
    <h3 class="p-3 text-center">TEAM MANAGEMENT</h3>
    <div class="table-responsive">
      <table class="table table-striped table-bordered">
        <thead>
          <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Role</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="user in teamMembers" :key="user.id">
            <td>{{ user.firstname }} {{ user.lastname }}</td>
            <td>{{ user.email }}</td>
            <td>{{ user.role }}</td>
            <td>
              <button
                class="btn btn-success m-1"
                v-on:click="getDashboard(user)"
              >
                View Dashboard
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <card>
      <h5 class="mb-0">
        <p class="mb-0" v-if="selectedUser">Management of {{ selectedUser }}</p>
        <p class="mb-0" v-if="!selectedUser">
          Choose a member to see his dashboard.
        </p>
      </h5>
    </card>
    <div>
      <card type="chart" id="long-card">
        <template slot="header">
          <div class="row">
            <div class="col-sm-6">
              <h5 class="card-category">Work management</h5>
              <h2 class="card-title">Working hours</h2>
              <button t ype="button" class="btn btn-success" @click="month">
                Month
              </button>
              <button type="button" class="btn btn-success" @click="week">
                Week
              </button>
            </div>
            <div class="col-sm-6"></div>
          </div>
        </template>
        <div class="chart-area">
          <BarMonthChart
            :arrayWorkingTimes="arrayWorkingTimes"
            v-show="barMonthChart"
            v-if="done"
          />
          <BarWeekChart :wArr="wArr" v-show="barWeekChart" v-if="done" />
        </div>
      </card>
    </div>
    <div class="row">
      <div class="col-lg-4">
        <card type="chart" id="short-card">
          <template slot="header">
            <h5 class="card-category">Work Management</h5>
            <h2 class="card-title">Hours details</h2>
          </template>
          <div class="chart-area">
            <PieChart v-if="done" :pieData="pieData" />
          </div>
        </card>
      </div>
      <div class="col-lg-4">
        <card type="chart" id="medium-card">
          <template slot="header">
            <h5 class="card-category"></h5>
            <h2 class="card-title"></h2>
          </template>
          <!-- <div class="chart-area">
            <AreaChart />
          </div> -->
        </card>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import authHeader from "../services/auth-header";
import BarWeekChart from "./Chart/BarWeekChart.vue";
import BarMonthChart from "./Chart/BarMonthChart.vue";
import PieChart from "./Chart/PieChart.vue";
import moment from "moment";
const apiEndPoint = process.env.VUE_APP_API_ENDPOINT;
export default {
  components: {
    BarWeekChart,
    BarMonthChart,
    PieChart,
  },
  data() {
    return {
      search: "",
      users: [],
      teamMembersId: [],
      teamMembers: [],
      done: false,
      selectedUser: "",
      barWeekChart: true,
      barMonthChart: true,
      arrayWorkingTimes: {
        January: 0,
        February: 0,
        March: 0,
        April: 0,
        May: 0,
        June: 0,
        July: 0,
        August: 0,
        September: 0,
        October: 0,
        November: 0,
        December: 0,
      },
      wArr: {},
      pieData: {
        overtime: 0,
        normal: 0,
        night: 0,
        majorated: 0,
      },
    };
  },
  computed: {
    currentUser() {
      return this.$store.state.auth.user;
    },
  },
  methods: {
    getDashboard(user) {
      this.done = false;
      for (const [key, value] of Object.entries(this.arrayWorkingTimes)) {
        this.arrayWorkingTimes[key] = 0;
      }
      for (const [key, value] of Object.entries(this.pieData)) {
        this.pieData[key] = 0;
      }
      console.log(this.arrayWorkingTimes);
      this.selectedUser = user.firstname + " " + user.lastname;
      let currentYear = new Date().getFullYear();
      axios
        .get(
          // `${apiEndPoint}/workingtimes/${user}?start=${currentYear}-01-01T00:00:00&end=${currentYear}-12-31T23:59:59`
          `${apiEndPoint}/workingtimes/${user.id}`,
          authHeader()
        )
        .then((response) => {
          console.log(response.data.data);
          let yearWorkingTimes = response.data.data;
          let wk = moment(new Date()).week();
          let firstWeek = wk - 12;
          for (let i = 0; i < 12; i++) {
            this.wArr[wk - 11 + i] = 0;
          }
          yearWorkingTimes.forEach((element) => {
            let elementStart = new Date(element.start);
            let elementEnd = new Date(element.end);
            let diff = moment(elementEnd).diff(moment(elementStart), "hours");

            // Hour per month Bar Chart
            if (new Date().getFullYear() == elementStart.getFullYear()) {
              let month = elementStart.toLocaleString("en-EN", {
                month: "long",
              });

              this.arrayWorkingTimes[month] += diff;
              let elementWeek = moment(elementStart).week();

              if (elementWeek >= firstWeek) {
                this.wArr[wk - (wk - elementWeek)] += diff;
              }
            }
            // console.log(elementStart.getHours());

            // Pie Chart Majorated hours
            if (diff > 7) {
              this.pieData.overtime += diff - 7;
            } else this.pieData.normal += diff;

            // Pie Chart weekend hours
            if (elementStart.getDay() == 0 || elementStart.getDay() == 6) {
              this.pieData.majorated += diff;
            }
            // if (elementStart.getHours() < 7 && elementStart.getHours() >= 21) {
            //   Majorated += diff;
            // }
          });
          console.log(this.pieData);

          this.done = true;
        })
        .catch((e) => {
          this.errors.push(e);
        });
    },
    getUser(id) {
      axios
        .get(`${apiEndPoint}/users/${id}`, authHeader())
        .then((response) => {
          this.teamMembers.push(response.data.data);
        })
        .catch((e) => {
          this.errors.push(e);
        });
    },
    month() {
      this.barWeekChart = false;
      this.barMonthChart = true;
    },
    week() {
      this.barWeekChart = true;
      this.barMonthChart = false;
    },
    getTeamMembers() {
      axios
        .get(
          `${apiEndPoint}/managing/${this.currentUser.user_id}`,
          authHeader()
        )
        .then((response) => {
          response.data.data.forEach((element) => {
            this.teamMembersId.push(element.employeeId);
            this.getUser(element.employeeId);
          });
          console.log(this.teamMembers);
          // console.log(this.teamMembers)
          // for (const [key, value] of Object.entries(response.data.data)) {
          //  this.teamMembersId.push()
          // }
        })
        .catch((e) => {
          this.errors.push(e);
        });
    },
    getUserWorkingTimes(id) {
      axios
        .get(`${apiEndPoint}/workingtimes/${id}`, authHeader())
        .then((response) => {
          return response.data.data;
        })
        .catch((e) => {
          this.errors.push(e);
        });
    },
    workingTimes(userId) {
      axios.get(`${apiEndPoint}/workingtimes/${userId}`).then((response) => {
        return response.end; //quoi mettre? dans la table working time il y a start et end mais pas de temps de travail
      });
    },
  },
  created() {
    this.getTeamMembers();
  },
  // methods:{
  //   result() {
  //     return this.users.filter((user) => {
  //       return user.firstname.toLowerCase().startsWith(this.Search);
  //     })
  //   }
  // }
};
</script>

<style scope="">
thead {
  background-color: rgba(39, 41, 61, 1);
}
.table-bordered {
  border: 0.0625rem solid rgba(255, 255, 255, 0.1);
}
.table-responsive {
  overflow: auto;
}
.table {
  width: 99% !important;
}
</style>