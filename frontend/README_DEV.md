main.js - entry point- creates App.vue instance and loads it

App.vue - highest level component- base template for the app
    template section - HTML
        lays out structure of components
        passes props to components
    script section - JavaScript
        imports section - loads components
        components section - registers components so they can be used in the template
        data section - holds shared data fields/states
        mounted section - fetches data from rails backend upon load
        methods - defines methods
    style - CSS
        sets style across component


HeaderBar.vue - top fold/header component

MaterialList.vue - List of materials and prices
    template
        when a list item is clicked, material is sent to parent/App


index.js - builds router, controls navigation


Selection functionality saved for later:
HomePage.vue - <MaterialList :materials="materials" @select="$emit('select', $event)"/>
MaterialList.vue -   @click="$emit('select', material)"
App.vue - handleSelect(material) {
            console.log('Selected material:', material);
        }
