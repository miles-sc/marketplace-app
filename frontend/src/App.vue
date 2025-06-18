<template>

    <div>
        <HeaderBar />
        <router-view :materials="materials" @select="handleSelect" />
    </div>

</template>


<script>

import HeaderBar from './components/HeaderBar.vue';
import MaterialList from './components/MaterialList.vue';

export default {
    name: 'App',
    components: {
        HeaderBar,
        MaterialList
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
</script>

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
