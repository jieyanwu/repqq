<template>
  <div class="about-container">
    <h1>关于我</h1>
    <div class="platform-cards">
      <div 
        v-for="platform in platforms" 
        :key="platform.id"
        class="platform-card"
        @click="openLink(platform.url)"
      >
        <img :src="platform.icon" :alt="platform.name" />
        <h3>{{ platform.name }}</h3>
      </div>
    </div>
    <button @click="fetchPlatforms">更新平台信息</button>
  </div>
</template>

<script>
export default {
  data() {
    return {
      platforms: [
        { id: 1, name: 'B站', url: 'https://space.bilibili.com/1294446419?spm_id_from=333.337.0.0', icon: 'https://img.picui.cn/free/2025/06/08/6845aaa9d4c94.webp' },
        { id: 2, name: 'GitHub', url: 'https://github.com/jieyanwu', icon: 'https://img.picui.cn/free/2025/06/08/6845aaa9a5909.webp' },
        { id: 3, name: 'Gitee', url: 'https://gitee.com', icon: 'https://img.picui.cn/free/2025/06/08/6845aaa997489.webp' }
      ]
    }
  },
  methods: {
    openLink(url) {
      window.open(url, '_blank');
    },
    async fetchPlatforms() {
      try {
        const response = await this.$axios.get('/api/platform-links');
        this.platforms = response.data;
      } catch (error) {
        console.error('获取平台链接失败:', error);
      }
    }
  }
};
</script>

<style scoped>
.about-container {
  padding: 2rem;
  text-align: center;
}
.platform-cards {
  display: flex;
  justify-content: center;
  gap: 2rem;
  margin-top: 2rem;
}
.platform-card {
  width: 120px;
  padding: 1rem;
  border-radius: 8px;
  background: #fff;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  cursor: pointer;
  transition: transform 0.2s;
}
.platform-card:hover {
  transform: translateY(-5px);
}
.platform-card img {
  width: 60px;
  height: 60px;
  object-fit: contain;
}
</style>