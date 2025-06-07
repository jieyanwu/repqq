<template>
    <div class="login-container">
        <div class="login-card">
            <h2>用户注册</h2>
            <form @submit.prevent="handleRegister">
                <div class="input-group">
                    <label for="username">用户名</label>
                    <input type="text" id="username" v-model="registerData.username" placeholder="请输入用户名" required />
                </div>

                <div class="input-group">
                    <label for="password">密码</label>
                    <input type="password" id="password" v-model="registerData.password" placeholder="请输入密码" required />
                </div>

                <button type="submit" class="btn-login">注册</button>
            </form>

            <div class="signup-link">
                <p>已有账号？<a href="/login">立即登录</a></p>
            </div>
        </div>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    name: 'RegisterView',
    data() {
        return {
            registerData: {
                username: '',
                password: ''
            },
            errorMessage: null
        };
    },
    methods: {
        async handleRegister() {
            try {
                const response = await axios.post('http://127.0.0.1:5000/api/auth/register', this.registerData);
                console.log('注册成功:', response.data);

                // 注册成功后跳转到登录页（假设你用了 vue-router）
                this.$router.push('/login');
            } catch (error) {
                console.error('注册失败:', error.response?.data || error.message);
                this.errorMessage = error.response?.data?.message || '注册失败，请重试';
                alert(this.errorMessage);
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