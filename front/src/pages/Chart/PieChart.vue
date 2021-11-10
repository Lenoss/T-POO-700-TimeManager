<script>
import { Pie } from "vue-chartjs";

export default {
  extends: Pie,
  props: {
    pieData: Object,
  },
  mounted() {
    let pData = [];
    pData[0] = this.pieData.overtime;
    pData[1] = this.pieData.majorated
    pData[2] = this.pieData.night
    pData[3] = this.pieData.normal;
    console.log(pData);
    this.gradient = this.$refs.canvas
      .getContext("2d")
      .createLinearGradient(0, 0, 0, 450);
    this.gradient2 = this.$refs.canvas
      .getContext("2d")
      .createLinearGradient(0, 0, 0, 450);

    // this.gradient.addColorStop(0, "rgba(255, 0,0, 0.5)");
    // this.gradient.addColorStop(0.5, "rgba(255, 0, 0, 0.25)");
    // this.gradient.addColorStop(1, "rgba(255, 0, 0, 0)");

    // this.gradient2.addColorStop(0, "rgba(0, 231, 255, 0.9)");
    // this.gradient2.addColorStop(0.5, "rgba(0, 231, 255, 0.25)");
    // this.gradient2.addColorStop(1, "rgba(0, 231, 255, 0)");
    this.renderChart(
      {
        labels: [
          "Daily overtime",
          "Majorated hours",
        //   "Night hours",
          "Normal hours",
        ],
        datasets: [
          {
            backgroundColor: ["#54daa1", "#2dce89", "#24a46d", "#1b7a51"],
            borderColor: ["#cecece", "#cecece", "#cecece", "#cecece"],
            data: [pData[0], pData[1], pData[3]],
          },
        ],
      },
      { responsive: true, maintainAspectRatio: false }
    );
  },
};
</script>