import VueRouter from 'vue-router'
import routes from './routes'

// configure router
const router = new VueRouter({
  routes, // short for routes: routes
  linkExactActiveClass: 'active',
  scrollBehavior: to => {
    if (to.hash) {
      return { selector: to.hash }
    } else {
      return { x: 0, y: 0 }
    }
  }
})
router.beforeEach((to, from, next) => {
  if (to.meta.requiresAuth) {
    const authUser = JSON.parse(window.localStorage.getItem('user'))
    if (!authUser || !authUser.jwt) {
      next({ name: 'login' })
    } else if (to.meta.genManagerAuth) {
      const authUser = JSON.parse(window.localStorage.getItem('user'))
      if (authUser.role === 'GeneralManager') {
        next()
      } else {
        next('/dashboard')
      }
    } else if (to.meta.memberAuth) {
      const authUser = JSON.parse(window.localStorage.getItem('user'))
      if (authUser.role === 'Member') {
        next()
      } else {
        next('/profile')
      }
    }
  } else {
    next()
  }
})
export default router
