import axios from 'axios';

const apiClient = axios.create({
  baseURL: 'http://127.0.0.1:5000'
});

// 请求拦截器：添加 Authorization 头
apiClient.interceptors.request.use(config => {
  const token = localStorage.getItem('token');
  if (token) {
    config.headers['Authorization'] = `Bearer ${token}`;
  }
  return config;
}, error => {
  return Promise.reject(error);
});

export default apiClient;