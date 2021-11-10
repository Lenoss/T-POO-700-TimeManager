import DashboardLayout from '@/layout/dashboard/DashboardLayout.vue'
import NotFound from '@/pages/NotFoundPage.vue'

const Dashboard = () =>
  import('@/pages/Dashboard.vue')
const Profile = () =>
  import('@/pages/Profile.vue')
const Login = () => import('@/pages/Login.vue')

const GeneralManager = () => import('@/pages/GeneralManager.vue')

const routes = [{
    path: '/',
    component: DashboardLayout,
    redirect: '/dashboard',
    children: [{
        path: 'dashboard',
        name: 'dashboard',
        component: Dashboard
      },
      {
        path: 'profile',
        name: 'profile',
        component: Profile
      },
      {
        path: '/general-manager',
        name: 'generalManager',
        component: GeneralManager
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

]

/**
 * Asynchronously load view (Webpack Lazy loading compatible)
 * The specified component must be inside the Views folder
 * @param  {string} name  the filename (basename) of the view to load.
function view(name) {
   var res= require('../components/Dashboard/Views/' + name + '.vue');
   return res;
};**/

export default routes
