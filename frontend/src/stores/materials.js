import { defineStore } from 'pinia'
import { ref } from 'vue'

export const useMaterialsStore=defineStore('materials',()=> {

    const materials = ref([])

    async function fetchMaterials(){
        try{
            const response=await fetch('http://localhost:3000/api/products')
            materials.value=await response.json()
        } catch (error) {
            console.error('Error fetching materials:',error)
        }
    }

    return { materials, fetchMaterials}
})
