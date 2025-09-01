<template>
    <div>
        <h1>Custom Manufacturing</h1>
    </div>

    <div class="image-row">
        <img :src="machined" alt="Machined part" />
        <img :src="bent" alt="Bent sheet metal part" />
        <img :src="tube" alt="Tube part" />
    </div>

    <div v-if="!job" class="upload-button">
        <input
            type="file"
            accept=".step,.stp"
            ref="stepFileInput"
            @change="handleFileUpload"
            style="display: none;"
        />
        <button @click="triggerUpload">Upload a STEP file</button>
    </div>

    <div v-else class="job-results">
        <h2>{{ job.filename }}</h2>
        <p><strong>Volume:</strong> {{ job.metrics.volume }} in<sup>3</sup></p>
        <p><strong>Surface Area:</strong> {{ job.metrics.surface_area }} in<sup>2</sup></p>

        <div class="image-row">
            <img :src="`http://localhost:3000/api/step_jobs/${job.job_id}/files/front.svg`" alt="Front view" />
            <img :src="`http://localhost:3000/api/step_jobs/${job.job_id}/files/iso.svg`" alt="Iso view" />
            <img :src="`http://localhost:3000/api/step_jobs/${job.job_id}/files/top.svg`" alt="Top view" />
        </div>

        <div class="materials-cost">
            <h2>Price by Material</h2>
            <table>
                <thead>
                <tr>
                    <th>Material</th>
                    <th>Price</th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="row in materialRows" :key="row.name">
                    <td>{{ row.name }}</td>
                    <td>{{ fmtMoney(row.cost) }}</td>
                </tr>
                </tbody>
            </table>
        </div>

    </div>
</template>

<script setup>
import bent from '../assets/bent.png';
import machined from '../assets/machined.png';
import tube from '../assets/tube.png';
import { ref, computed } from 'vue' //enables the ability reference other/hidden objects
import { useMaterialsStore } from '@/stores/materials'

const stepFileInput = ref(null)
/*creates an element that can be referenced by this name. input block in
template section hooks up to this object */
const job=ref(null)
const store = useMaterialsStore()

function triggerUpload() { //simulates a click on this element
  stepFileInput.value.click()
}

async function handleFileUpload(event) {
  const file = event.target.files[0]
  if (!file) return

  const formData = new FormData()
  formData.append('file',file)

  try{
    const response=await fetch('http://localhost:3000/api/step_jobs', {
      method:'POST',
      body:formData
    })
    if (!response.ok){
      throw new Error('Upload failed')
    }
    const result = await response.json()
    console.log('Upload succeeded:', result)
    job.value = result
  } catch (error) {
    console.error('Error uploading file:', error)
  }
}

const currency = new Intl.NumberFormat(undefined, { style: 'currency', currency: 'USD' })
function fmtMoney(n) { return currency.format(Number(n || 0)) }

const materialRows = computed(() => {
  if (!job.value?.metrics?.volume) return []
  const volume = Number(job.value?.metrics?.volume ?? 0)
  return store.materials.map(m => {
    const unitPrice = Number(m.price || 0)
    const cost = unitPrice * volume
    return {
      name: m.name,
      cost
    }
  })
})
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

.job-results {
  text-align: center;
  margin-top: 2rem;
}

/* .job-results img {
  max-width: 200px;
  margin: 0 1rem;
} */

.materials-cost {
  margin: 2rem auto 0;
  max-width: 600px;
  text-align: center;
}

.materials-cost table {
  margin: 0 auto;
  width: 100%;
  border-collapse: collapse;
}

.materials-cost th,
.materials-cost td {
  padding: 0.5rem 0.75rem;
  border-bottom: 1px solid #ddd;
}

.materials-cost tbody tr {
  cursor: pointer;
  transition: background-color 0.2s ease, color 0.2s ease;
}

.materials-cost tbody tr:hover {
  background-color: #8B0000;
  color: #ffffff;
}

</style>
