<script>
import { Bar } from "vue-chartjs";

export default {
  extends: Bar,
  props: {
    arrayWorkingTimes: Object
  },
  watch: {
    arrayWorkingTimes: function (newValue, oldValue) {
      console.log("newValue: %s, previousValue: %s", newValue, oldValue);
    }
  },
  mounted() {
    let chartData = [];
    for (const [key, value] of Object.entries(this.arrayWorkingTimes)) {
       chartData.push(value);
    }

    this.renderChart(
      {
        labels: [
          "January",
          "February",
          "March",
          "April",
          "May",
          "June",
          "July",
          "August",
          "September",
          "October",
          "November",
          "December",
        ],
        datasets: [
          {
            label: "Hour per month",
            backgroundColor: "#2dce89",
            data: chartData,
          },
        ],
      },
      { responsive: true, maintainAspectRatio: false }
    );
  },
};
</script>