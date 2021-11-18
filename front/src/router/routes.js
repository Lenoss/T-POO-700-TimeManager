import DashboardLayout from '@/layout/dashboard/DashboardLayout.vue'
import NotFound from '@/pages/NotFoundPage.vue'
import VueRouter from 'vue-router'

const Dashboard = () => import('@/pages/Dashboard.vue')
const Profile = () => import('@/pages/Profile.vue')
const Login = () => import('@/pages/Login.vue')
const TeamMemberView = () => 
  import('@/pages/TeamMemberView.vue')

const Signup = () => import('@/pages/Signup.vue')

const GeneralManager = () => import('@/pages/GeneralManager.vue')

const routes = [
  {
    path: '/',
    component: DashboardLayout,
    redirect: '/dashboard',

    children: [
      {
        path: 'dashboard',
        name: 'dashboard',
         meta: { memberAuth: true, managerAuth: true },

        component: Dashboard
      },
      {
        path: 'profile',
        name: 'profile',
        meta: { memberAuth: true, managerAuth: true },

        component: Profile
      },
      {
        path: '/general-manager',
        name: 'generalManager',
        meta: {  genManagerAuth: true },

        component: GeneralManager
      },
      {
        path: '/team-review',
        name: 'team-review',
        meta: { managerAuth: true },

        component: TeamMemberView
      }
    ]
  },
  {
    path: '*',
    component: NotFound
  },
  {
    path: '/login',
    name: 'login',
    component: Login
  },
  {
    path: '/signup',
    name: 'signup',
    component: Signup
  }
]




export default routes
