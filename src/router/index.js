import { createRouter, createWebHistory } from 'vue-router'
// import RePcqqWeb from '../pages/repcqqweb.vue'

const routes = [
  {
    path: '/',
    name: 'index',
    component: () => import('../pages/index.vue')
  },
  {
    path: '/repcqqweb',
    name: 'RePcqqWeb',
    component: () => import('../pages/repcqqweb.vue')
  },
  {
    path: '/love',
    name: 'LoverPage',
    component: () => import('../pages/loverPage.vue')
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router