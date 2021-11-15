import axios from 'axios';

const API_URL =  process.env.VUE_APP_API_ENDPOINT;

class AuthService {
  login(user) {
    return axios
      .post(API_URL + '/sign_in', {
        email: user.email,
        password: user.password
      })
      .then(response => {
        if (response.data.jwt) {
          localStorage.setItem('user', JSON.stringify(response.data));
          console.log("stored");
        }

        return response.data;
      });
  }

  logout() {
    localStorage.removeItem('user');
  }

//   register(user) {
//     return axios.post(API_URL + 'signup', {
//       email: user.email,
//       email: user.email,
//       password: user.password
//     });
//   }
}

export default new AuthService();