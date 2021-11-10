<template>
  <div>
    <div class="row">
      <div class="col-12">
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
            <h5 class="card-category">Lorem Ipsum</h5>
            <h2 class="card-title">Lorem Ipsum</h2>
          </template>
          <div class="chart-area">
            <AreaChart />
          </div>
        </card>
      </div>
    </div>
  </div>
</template>

<script>
import BarWeekChart from "./Chart/BarWeekChart.vue";
import BarMonthChart from "./Chart/BarMonthChart.vue";
import PieChart from "./Chart/PieChart.vue";
import AreaChart from "./Chart/AreaChart.vue";
import axios from "axios";
import moment from "moment";

const apiEndPoint = process.env.VUE_APP_API_ENDPOINT;

let user = "1";
export default {
  name: "App",
  components: {
    BarWeekChart,
    BarMonthChart,
    PieChart,
    AreaChart,
  },
  data() {
    return {
      chartData: {
        GrossSalary: 2500,
        NetSalary: 1750,
        IncomeTaxes: 750,
        Taxes: 900,
      },
      done: false,

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
        night: 1,
        majorated : 0
      }
    };
  },
  created() {
    let currentYear = new Date().getFullYear();
    axios
      .get(
        // `${apiEndPoint}/workingtimes/${user}?start=${currentYear}-01-01T00:00:00&end=${currentYear}-12-31T23:59:59`
        `${apiEndPoint}/workingtimes/${user}`
      )
      .then((response) => {
        let yearWorkingTimes = response.data.data;
        let wk = moment(new Date()).week();
        let firstWeek = wk - 12;
        let majorated = 0;
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
          }
          else this.pieData.normal += diff;

          // Pie Chart weekend hours
          if (elementStart.getDay() == 0 || elementStart.getDay() == 6){
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
  methods: {
    month() {
      this.barWeekChart = false;
      this.barMonthChart = true;
    },
    week() {
      this.barWeekChart = true;
      this.barMonthChart = false;
    },
  },
};
</script>
<style>
#long-card {
  width: auto;
  height: 540px;
}
#short-card,
#medium-card {
  height: 520px;
}
#medium-card {
  width: 206%;
}
@media (max-width: 970px) {
  #medium-card {
    width: auto;
  }
}
</style>
