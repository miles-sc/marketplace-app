import { createRouter, createWebHistory } from 'vue-router';


import App from '../App.vue';
import MaterialGuide from '@/components/MaterialGuide.vue';
import Home from '@/components/Home.vue';

const routes = [
    {
        path: '/',
        name: 'Home',
        component: Home
    },
    {
        path: '/materials/:id',
        name: 'MaterialGuide',
        component: MaterialGuide,
        props: true
    }
]
