export default function authHeader() {
    let user = JSON.parse(localStorage.getItem('user'));
    if (user && user.jwt) {
        const config = {
            headers: { Authorization: `Bearer ${user.jwt}` }
        };
      return config;
    } else {
      return {};
    }
  }