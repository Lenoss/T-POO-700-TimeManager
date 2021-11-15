<template>
  <div>
    <h3 class="p-3 text-center">USER LIST</h3>
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
          <tr v-for="user in users" :key="user.id"> 
            <td>{{ user.firstname }} {{ user.lastname }}</td>
            <td>{{ user.email }}</td>
            <td>{{ user.role }}</td>
            <td >
              <button class="btn btn-success m-1">Promote</button>
              <button class="btn btn-danger m-1">Delete</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
import axios from "axios";

const apiEndPoint = process.env.VUE_APP_API_ENDPOINT;

export default {
  data() {
    return {
      users: [],
    };
  },
  mounted() {
    axios
      .get(`${apiEndPoint}/users`)
      .then((response) => {
        this.users = response.data.data;
        console.log(this.users);
      })
      .catch((e) => {
        this.errors.push(e);
      });
  },
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