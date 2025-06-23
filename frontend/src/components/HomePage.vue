<template>

    <div>
        <h1 style="background:#eee">HomePage mounted</h1>
        <MaterialList :materials="materials"/>
    </div>

</template>

<script>
import MaterialList from './MaterialList.vue';

export default {
    name: 'HomePage',
    components: {
    MaterialList
    },
    props: {
        materials: {
        type: Array,
        required: true
    }
  }
}

</script>

<style scoped>
</style>
