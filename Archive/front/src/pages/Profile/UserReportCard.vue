<template>
  <card>
    <p class="card-text"></p>
    <div class="author">
      <h5 class="title">{{ todayDate }}</h5>
      <div class="row">
        <div class="col">
          <base-input
            label="Arrival time"
            v-model="Arrival"
            placeholder="Please confirm arrival"
            ref="arriv"
          >
          </base-input>
          <!-- <vue-timepicker format="HH:mm"></vue-timepicker> -->
        </div>

        <div class="col">
          <base-input
            label="Departure time"
            v-model="Departure"
            placeholder="Please confirm departure"
          >
          </base-input>
        </div>
      </div>
      <div class="row d-flex justify-content-center">
        <h5 id="info">{{ confirmStatusText }}</h5>
      </div>
      <div class="row">
        <div class="col d-flex justify-content-center">
          <base-button
            type="primary"
            fill
            v-on:click="confirmArrival"
            :disabled="clockStatus == 'done'"
            >Clock in</base-button
          >
        </div>
      </div>
    </div>

    <p></p>
  </card>
</template>
<script>
import VueTimepicker from "vue2-timepicker";
import moment from "moment";
let workingtime = [];
export default {
  props: {
    user: {
      type: Object,
      default: () => {
        return {};
      },
    },
  },
  data() {
    return {
      todayDate: "",
      Arrival: "",
      Departure: "",
      confirmStatusText: "Please confirm your arrival",
      Arrived: true,
      clockStatus: "arriving"
    };
  },
  components: {
    VueTimepicker,
  },
  mounted() {
    this.todayDate = moment().format("MMMM Do YYYY");
    // this.focusInput();
  },
  methods: {
    //      focusInput() {
    // this.$refs.arriv.$el.children[0].focus();

    //      },

    confirmArrival: function () {
      if (this.clockStatus == "arriving") {
        if (confirm("Do you want to confirm your arrival?")) {
          this.Arrival = moment().format("LTS");
          this.confirmStatusText = "Press confirm to validate departure.";
          let data = {
            Arrived: this.Arrived,
            Arrival: this.Arrival,
          };
          this.clockStatus = "arrived";

          workingtime[0] = new Date();
          this.$emit("clockIn", data);
        }
      } else if (this.clockStatus == "arrived") {
        console.log("???  ");
        if (confirm("Do you want to confirm your departure?")) {
          this.Departure = moment().format("LTS");
          this.confirmStatusText = "Arrival and departure validated for today.";
          let data = {
            Arrived: this.Arrived,
            Arrival: this.Arrival,
          };
          workingtime[1] = new Date();
          this.$emit("clockIn", data);
          this.$emit("newWorkingTime", workingtime);
          workingtime = [];
          this.clockStatus = "done";
        }
      } else {
        alert("You already clocked in for today. Come back tomorrow!");
      }
    },
  },
};
</script>
<style>
#info {
  color: #e3dc54;
}
</style>
