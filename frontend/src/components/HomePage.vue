<template>
    <div>
        <h1>Custom Manufacturing</h1>
    </div>

    <div class="image-row">
        <img :src="machined" alt="Machined part" />
        <img :src="bent" alt="Bent sheet metal part" />
        <img :src="tube" alt="Tube part" />
    </div>

    <div class="upload-button">
        <input
            type="file"
            accept=".step,.stp"
            ref="stepFileInput"
            @change="handleFileUpload"
            style="display: none;"
        />
        <button @click="triggerUpload">Upload a STEP file</button>
    </div>
</template>

<script setup>
import bent from '../assets/bent.png';
import machined from '../assets/machined.png';
import tube from '../assets/tube.png';
import { ref } from 'vue' //enables the ability reference other/hidden objects

const stepFileInput = ref(null)
/*creates an element that can be referenced by this name. input block in
template section hooks up to this object */

function triggerUpload() { //simulates a click on this element
  stepFileInput.value.click()
}

function handleFileUpload(event) {
  const file = event.target.files[0]
  if (file) {
    console.log('Selected file:', file)
    //next step: send to backend or store in state
  }
}
</script>

<style scoped>

h1 {
  text-align: center;
}

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

button {
  padding: 0.5rem 1rem;
  font-size: 1.5rem;
  font-weight: bold;
  background-color: #8B0000;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
}

button:hover {
  transform: scale(1.05);
  transition: transform 0.2s ease;
}

.upload-button {
  display: flex;
  justify-content: center;
  margin-top: 2rem;
}
</style>
