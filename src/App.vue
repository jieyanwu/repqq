<template>
  <ul class="list-head">
    <li>Vue 3</li>
    <li>Vite</li>
    <li>TypeScript</li>
    <li>ESLint</li>
    <li>Prettier</li>
    <li>Vitest</li>
    <li>Pinia</li>
    <li>Vue Router</li>
    <li>Axios</li>
    <li>Tailwind CSS</li>
  </ul>
  <section class="container">
    <div>
      <div class="head">
        <h1>PC Manager</h1>
        <p>PC 管理器是一个基于 Vue 3 和 Vite 的前端项目，旨在提供一个简单易用的 PC 管理工具。</p>
        <p>当前版本：{{ datas[0]?.ver }}</p>
      </div>
      
      <AppList :datas="datas" />
    </div>
  </section>
</template>

<script>
import axios from 'axios';
import AppList from './components/AppList.vue';

export default {
  name: 'App',
  components: {
    AppList
  },
  data () {
    return {
      datas: [],
      limit: 42,
      page: 1,
      isLoading: false // 新增加载状态
    }
  },
  mounted() {
    console.log('滚动事件监听已添加');
    // 首次加载 30 条数据
    this.fetchData();
    // 监听滚动事件
    window.addEventListener('scroll', this.handleScroll);
  },
  beforeUnmount() {
    console.log('滚动事件监听已移除');
    // 组件卸载前移除滚动事件监听
    window.removeEventListener('scroll', this.handleScroll);
  },
  methods: {
    async fetchData() {
      if (this.isLoading) return; // 如果正在加载，直接返回
      this.isLoading = true;
      try {
        const url = `http://127.0.0.1:5000/api/softdata?limit=${this.limit}&page=${this.page}`;
        console.log('请求的 URL:', url);
        console.log('当前页码:', this.page); // 添加日志输出
        const response = await axios.get(url);
        this.datas = this.datas.concat(response.data);
        this.page++;
      } catch (error) {
        console.error('数据获取失败:', error);
      } finally {
        this.isLoading = false; // 加载完成，重置状态
      }
    },
    handleScroll() {
      console.log('滚动事件触发，scrollTop:', document.documentElement.scrollTop);
      const { scrollTop, scrollHeight, clientHeight } = document.documentElement;
      console.log('scrollTop:', scrollTop, 'scrollHeight:', scrollHeight, 'clientHeight:', clientHeight);
      if (scrollTop + clientHeight >= scrollHeight - 200) {
        this.fetchData();
      }
    }
  }
}
</script>

<style lang="scss" scoped>
@import './assets/styles/variables.scss';

* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

html {
  font-size: 16px;
}

body {
  background-color: $background-color;
  color: $text-color;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  line-height: 1.6;
  padding: 0 1rem;
}

#app {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem 1rem;
  text-align: center;
}

.list-head {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  list-style-type: none;
  padding: 1rem;
  background-color: #fff;
  border-radius: 12px;
  box-shadow: $shadow;
  margin-bottom: 2rem;

  li {
    margin: 0.5rem 0.75rem;
    padding: 0.5rem 1rem;
    background-color: $theme-color;
    color: white;
    border-radius: 8px;
    font-size: 1rem;
    transition: background-color $transition-time;

    &:hover {
      background-color: #1a3cd6;
      cursor: pointer;
    }
  }
}

.head{
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-bottom: 2rem;
}

section.container > div > div.head > h1 {
  font-size: 2.5rem;
  font-weight: bold;
  color: $theme-color;
  margin-bottom: 1rem;
}

section.container > div > div.head > p {
  font-size: 1.1rem;
  margin-bottom: 1.5rem;
  color: #555;
}

section.container > div > div.head > p:nth-child(3) {
  font-size: 1rem;
  color: #777;
  margin-bottom: 2rem;
}
</style>