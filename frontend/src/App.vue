<template>
    <nav>
        <RouterLink to="/">HelloWorld</RouterLink>
        <RouterLink to="/HeaderBar">HeaderBar</RouterLink>
    </nav>
    <RouterView/>
</template>

<script setup>
import { RouterLink, RouterView } from 'vue-router'
</script>


<!-- <script setup>
import { RouterLink, RouterView } from 'vue-router';
</script> -->




<!-- <script>

export default {
    name: 'App',
    components: {
    },

    data() {
        return{
            materials: []
        };
    },

    mounted() {
        fetch('http://localhost:3000/products')
      .then(response => response.json())
      .then(data => {
        this.materials = data;
      })
      .catch(error => {
        console.error('Error fetching materials:', error);
      });
    },

    methods: {
        formatPrice(price) {
            return Number(price).toFixed(2);
        },
        handleSelect(material) {
            console.log('Selected material:', material);
        }
    }
}
</script> -->

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 0;
  ul {
    list-style-position: inside;
    padding-left: 0;
    }

    .content {
  display: flex;
}

.material-list {
  width: 50%;
  padding: 1rem;
  text-align: left;
}

}
</style>
