<template>
  <div>
    <h1>Material Guide</h1>
    <section v-for="material in materials" :key="material.id">
      <h2>{{ material.name }}</h2>
      <p>{{ material.description }}</p>
    </section>
  </div>
</template>

<script>
export default {
  name: 'MaterialGuide',
  props: {
    materials: {
      type: Array,
      required: true
    }
  }
}
</script>

<style scoped>
h1 {
  text-align: center;
  margin-bottom: 2rem;
}

section {
  margin-bottom: 2rem;
}

h2 {
  font-size: 1.2rem;
  margin-bottom: 0.5rem;
  color: #2c3e50;
}

p {
  line-height: 1.5;
  color: #444;
}
</style>
