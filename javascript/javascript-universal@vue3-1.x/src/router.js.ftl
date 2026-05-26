import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'

const routes = [{
  path: '/',
  name: 'Home',
  component: HomeView
},{
  path: '/about',
  name: 'About',
  component: () => import('../pages/AboutView.vue')
}]