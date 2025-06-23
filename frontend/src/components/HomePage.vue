<template>
    <div>
        <h1>Custom Manufacturing</h1>
    </div>

    <div class="image-row">
        <img :src="machined" alt="Machined part" />
        <img :src="bent" alt="Bent sheet metal part" />
        <img :src="tube" alt="Tube part" />
    </div>

    <div>
        <MaterialList/>
    </div>
</template>

<script setup>
import MaterialList from './MaterialList.vue';
import bent from '../assets/bent.png';
import machined from '../assets/machined.png';
import tube from '../assets/tube.png';
</script>

<style scoped>
.image-row {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-wrap: nowrap;
  gap: clamp(0.5rem, 2vw, 2rem); /* Scales with screen size */
  width: 100%;
  max-width: 100vw;
  overflow: hidden;
  padding: 1rem 0;
}

.image-row img {
  max-width: clamp(80px, 25vw, 300px); /* Shrinks on small screens */
  height: auto;
  object-fit: contain;
}
</style>
