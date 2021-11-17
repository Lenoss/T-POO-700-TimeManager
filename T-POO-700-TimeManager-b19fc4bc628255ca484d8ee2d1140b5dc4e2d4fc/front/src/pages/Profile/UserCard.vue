<template>
  <card type="user">
    <p class="card-text">
    </p>
    <div class="author">

        <!-- <img class="avatar" src="img/anime6.png" alt="..."> -->
        <h5 class="title">{{user.role}}</h5>
      
      <!-- <p class="description">
        {{user.title}}
      </p> -->
    </div>
    <p></p>
    <!-- <p class="card-description">
      {{user.description}}
    </p> -->
    <!-- <div slot="footer" class="button-container">
      <base-button icon round class="btn-facebook">
        <i class="fab fa-facebook"></i>
      </base-button>
      <base-button icon round class="btn-twitter">
        <i class="fab fa-twitter"></i>
      </base-button>
      <base-button icon round class="btn-google">
        <i class="fab fa-google-plus"></i>
      </base-button>
    </div> -->
  </card>
</template>
<script>
  export default {
    props: {
      user: {
        type: Object,
        default: () => {
          return {};
        }
      }
    }
  }
</script>
<style>
</style>
