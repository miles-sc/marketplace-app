<template>
    <div>
        <h1>{{ message }}</h1>
        <ul>
            <li v-for="material in materials" :key="material.id">
                {{  material.name }} - ${{ material.price.toFixed(2) }}
            </li>

        </ul>
    </div>
</template>

<script>
export default {
    name: 'App',
    data() {
        return{
            message: 'Welcome to the Materials Market',
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
  margin-top: 60px;
}
</style>
