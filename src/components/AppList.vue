<template>
    <ul class="list">
      <li v-for="(item, index) in datas" :key="index" class="app-card">
        <img :src="item.lg" alt="logo" class="app-logo" />
        <div class="info">
          <h2 class="app-name">{{ item.sn }}</h2>
          <!-- 修改这一行，移除过滤器 -->
          <p class="app-description">{{ truncate(item.fe) }}</p>
          <div class="size-download-container">
            <span class="app-size">{{ item.fs }}</span>
            <a :href="item.download_https_url" class="download-button">下载</a>
          </div>
        </div>
      </li>
    </ul>
  </template>
  
  <script>
  export default {
    name: 'AppList',
    props: {
      datas: {
        type: Array,
        required: true
      }
    },
    // 把过滤器逻辑移到方法里
    methods: { 
      truncate(str) { 
        // 这里实现之前过滤器的逻辑，假设是截取前8个字符并添加省略号
        return str.length > 8 ? str.slice(0, 8) + '...' : str; 
      }
    }
  };
  </script>
  
  <style lang="scss" scoped>
  @import '../../src/assets/styles/variables.scss';
  
  .list {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 2rem;
    list-style: none;
  }
  
  .app-card {
    background-color: $card-bg;
    border: 1px solid $border-color;
    border-radius: 16px;
    overflow: hidden;
    box-shadow: $shadow;
    transition: transform $transition-time, box-shadow $transition-time;
    padding: 1.5rem;
    text-align: center;
  
    &:hover {
      transform: translateY(-8px);
      box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
    }
  }
  
  .info {
    display: flex;
    flex-direction: column;
    align-items: center;
  }
  .app-logo {
    width: 60px;
    height: 60px;
    margin-bottom: 1rem;
  }
  .app-name {
    white-space: normal;
    word-wrap: break-word;
    margin: 0;
  }
  
  .app-description {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 100%;
  }
  
  .size-download-container {
    display: flex;
    flex-direction: column;
    justify-content: space-around;
    align-items: center;
    width: 100%;
  }
  
  .app-size {
    margin-bottom: 0;
  }
  
  .download-button {
    text-decoration: none;
    display: inline-block;
    width: 65px;
    background-color: $theme-color;
    color: white;
    padding: 0.8rem 1.5rem; // 增大按钮的内边距
    font-size: 1.1rem; // 增大按钮的字体大小
  }
  </style>