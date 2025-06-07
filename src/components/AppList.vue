<template>
  <ul class="app-list">
    <li v-for="(item, index) in datas" :key="index" class="app-card">
      <img :src="item.lg || 'default-logo.png'" alt="Logo" class="app-logo" />
      <div class="app-info">
        <h3 class="app-name">{{ truncate(item.sn) }}</h3>
        <p class="app-description">{{ truncate(item.fe, 30) }}</p>
        <div class="app-meta">
          <span class="app-size">大小：{{ item.fs }}</span>
          <a :href="item.download_https_url" class="download-btn" target="_blank">下载</a>
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
      truncate(text) {
        const str = text || '';
        return str.length > 20 ? str.slice(0, 20) + '...' : str;
      }
    }
  };
</script>
<style lang="scss" scoped>
  @import '@/assets/styles/variables.scss';
  @import '@/assets/styles/colors/blue.scss';
  // @import '@/assets/styles/colors/purple.scss';

  .app-list {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 2rem;
    list-style: none;
    padding: 0;
    margin: 0;
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

  .app-logo {
    width: 80px;
    height: 80px;
    object-fit: contain;
    margin-bottom: 1rem;
    border-radius: 8px;
  }

  .app-info {
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .app-name {
    font-size: 1.2rem;
    font-weight: bold;
    color: $text-color;
    margin-bottom: 0.5rem;
    white-space: normal;
    word-wrap: break-word;
  }

  .app-description {
    font-size: 0.95rem;
    color: #777;
    margin-bottom: 1rem;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 100%;
  }

  .app-meta {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
    margin-top: auto;
  }

  .app-size {
    font-size: 0.85rem;
    color: #999;
  }

  .download-btn {
    display: inline-block;
    background-color: $theme-color;
    color: white;
    padding: 0.5rem 1rem;
    font-size: 0.95rem;
    border-radius: 4px;
    text-decoration: none;
    transition: background-color $transition-time;

    &:hover {
      background-color: darken($theme-color, 10%);
    }
  }

/* 移动端适配 */
@media (max-width: 768px) {
  .app-list {
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
    gap: 1rem;
  }

  .app-card {
    padding: 1rem;
  }

  .app-logo {
    width: 60px;
    height: 60px;
  }

  .app-name {
    font-size: 1rem;
  }

  .app-description {
    white-space: normal;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
  }

  .download-btn {
    padding: 0.4rem 0.8rem;
    font-size: 0.85rem;
  }
}
</style>