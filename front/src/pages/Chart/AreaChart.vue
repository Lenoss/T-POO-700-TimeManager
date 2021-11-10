<script>
import { Line } from "vue-chartjs";

export default {
    extends: Line,
    data() {
        return {
            gradient: null,
            gradient2: null
        };
    },
    mounted() {
        this.gradient = this.$refs.canvas
            .getContext("2d")
            .createLinearGradient(0, 0, 0, 450);
        // this.gradient2 = this.$refs.canvas
            //   .getContext("2d")
            //   .createLinearGradient(0, 0, 0, 450);

        this.gradient.addColorStop(0, "rgba(0, 255,100, 0.5)");
        this.gradient.addColorStop(0.5, "rgba(0, 255, 100, 0.25)");
        // this.gradient.addColorStop(1, "rgba(0, 255, 100, 0)");

        // this.gradient2.addColorStop(0, "rgba(0, 231, 255, 0.9)");
        // this.gradient2.addColorStop(0.5, "rgba(0, 231, 255, 0.25)");
        // this.gradient2.addColorStop(1, "rgba(0, 231, 255, 0)");

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
                "october",
                "November",
                "December"
            ],
            datasets: [{
                label: "Data One",
                borderColor: "#2dce89",
                pointBackgroundColor: "#cecece",
                borderWidth: 1,
                pointBorderColor: "#7f7f7f",
                backgroundColor: this.gradient,
                data: [25, 63, 98, 16, 46, 73, 52, 96, 22, 75, 26, 12, 68]
            },
            //   {
            //     label: "Data Two",
            //     borderColor: "#05CBE1",
            //     pointBackgroundColor: "white",
            //     pointBorderColor: "white",
            //     borderWidth: 1,
            //     backgroundColor: this.gradient2,
            //     data: [60, 55, 32, 10, 2, 12, 53]
            //   }
            ]
        }, { responsive: true, maintainAspectRatio: false });
    }
};
</script>