import { createRouter, createWebHistory } from 'vue-router';


import App from '../App.vue';
import MaterialList from '../views/MaterialList.vue';
import MaterialDetail from '../views/MaterialDetail.vue';

const routes = [
    {
        path: '/',
        name: 'Home',
        component: MaterialList
    },
    {
        path: '/materials/:id',
        name: 'MaterialDetail',
        component: MaterialDetail,
        props: true
    }
]
