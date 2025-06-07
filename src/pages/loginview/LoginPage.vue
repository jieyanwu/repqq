<template>
  <div class="login-container">
    <div class="login-card">
      <h2>用户登录</h2>
      <form @submit.prevent="handleLogin">
        <div class="input-group">
          <label for="username">用户名</label>
          <input type="text" id="username" v-model="loginData.username" placeholder="请输入用户名" required />
        </div>

        <div class="input-group">
          <label for="password">密码</label>
          <input type="password" id="password" v-model="loginData.password" placeholder="请输入密码" required />
        </div>

        <div class="options">
          <label>
            <input type="checkbox" v-model="loginData.rememberMe" />
            记住我
          </label>
          <a href="#">忘记密码？</a>
        </div>

        <button type="submit" class="btn-login">登录</button>
      </form>

      <div class="signup-link">
        <p>还没有账号？<a href="/register">注册一个</a></p>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      loginData: {
        username: '',
        password: '',
        rememberMe: false
      }
    };
  },
  methods: {
    async handleLogin() {
      try {
        const res = await axios.post('http://127.0.0.1:5000/api/auth/login', {
          username: this.loginData.username,
          password: this.loginData.password
        });

        console.log('登录成功:', res.data);

        // 保存 Token 和用户名到 localStorage
        localStorage.setItem('token', res.data.token);
        localStorage.setItem('username', res.data.username);

        // 跳转到主页
        this.$router.push('/');
      } catch (err) {
        alert('登录失败，请检查用户名或密码');
        console.error(err);
      }
    }
  }
};
</script>

<style scoped lang="scss">
$primary-color: #4f46e5;
$secondary-color: #6366f1;
$background-gradient: linear-gradient(135deg, $primary-color, $secondary-color);
$input-bg: rgba(255, 255, 255, 0.1);
$input-border: rgba(255, 255, 255, 0.3);
$text-color: white;

.login-container {
  border-radius: 2rem;
  min-height: 100vh;
  background: $background-gradient;
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 2rem;
}

.login-card {
  background-color: rgba(255, 255, 255, 0.1);
  border-radius: 16px;
  backdrop-filter: blur(10px);
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
  width: 100%;
  max-width: 400px;
  padding: 2rem;
  color: $text-color;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;

  h2 {
    text-align: center;
    margin-bottom: 1.5rem;
  }

  form {
    display: flex;
    flex-direction: column;
    gap: 1rem;
  }

  .input-group {
    display: flex;
    flex-direction: column;

    label {
      margin-bottom: 0.4rem;
      font-size: 0.9rem;
    }

    input[type="text"],
    input[type="password"] {
      padding: 0.75rem 1rem;
      border: 1px solid $input-border;
      border-radius: 8px;
      background-color: $input-bg;
      color: white;
      font-size: 1rem;

      &:focus {
        outline: none;
        border-color: white;
        box-shadow: 0 0 0 2px rgba(white, 0.4);
      }
    }
  }

  .options {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 0.9rem;

    a {
      color: white;
      text-decoration: underline;

      &:hover {
        opacity: 0.8;
      }
    }
  }

  .btn-login {
    padding: 0.75rem;
    background-color: white;
    color: $primary-color;
    border: none;
    border-radius: 8px;
    font-size: 1rem;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s ease;

    &:hover {
      background-color: lighten(white, 10%);
    }
  }

  .signup-link {
    margin-top: 1.5rem;
    text-align: center;
    font-size: 0.9rem;

    a {
      color: white;
      text-decoration: underline;
      margin-left: 0.3rem;

      &:hover {
        opacity: 0.8;
      }
    }
  }
}
</style>