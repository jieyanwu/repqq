<template>
  <div class="home-container">
    <header class="hero-section">
      <h1>欢迎来到我的项目</h1>
      <p>这是一个简洁美观的首页模板，适用于任何 Vue 项目。</p>
      <!-- <a href="/about" class="btn-primary">了解更多</a> -->
    </header>

    <section class="features-section">
      <div class="feature-carousel">
        <div class="carousel-track">
          <div v-for="(card, index) in featureCards" :key="index" class="feature-card">
            <h3>{{ card.title }}</h3>
            <p>{{ card.description }}</p>
          </div>
        </div>
      </div>
    </section>

    <footer class="footer">
      <p>© 2025 我的项目. 保留所有权利.</p>
    </footer>
  </div>
</template>

<script>
export default {
  name: 'IndexPage',
  data() {
    return {
      featureCards: [
        { title: '🚀 快速启动', description: '基于 Vue 3 和 Vite 构建，开箱即用。' },
        { title: '🎨 美观 UI', description: '使用 SCSS 和 Flexbox 实现现代设计语言。' },
        { title: '📱 响应式布局', description: '兼容各种设备，从手机到桌面端都能完美显示。' },
        { title: '⚡️ 高性能', description: '优化的代码结构和加载策略。' },
        { title: '🔧 易于定制', description: '模块化设计，方便扩展和修改。' }
      ]
    };
  }
};
</script>

<style scoped lang="scss">
@import "@/assets/styles/variables.scss";

// $primary-color: #4f46e5;
// $secondary-color: #6366f1;
// $background-gradient: linear-gradient(135deg, $primary-color, $secondary-color);
// $text-color: white;

.home-container {
  min-height: 100vh;
  background: $background-color;
  color: $text-color;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  display: flex;
  flex-direction: column;
  align-items: center;
  border-radius: 2rem;
  padding: 2rem;
  box-sizing: border-box;
}

.hero-section {
  text-align: center;
  margin-bottom: 3rem;

  h1 {
    font-size: 2.5rem;
    margin-bottom: 1rem;
  }

  p {
    font-size: 1.2rem;
    margin-bottom: 2rem;
    max-width: 600px;
  }
}

.btn-primary {
  display: inline-block;
  padding: 0.75rem 1.5rem;
  background-color: rgba(255, 255, 255, 0.6);
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
  color: $text-color;
  border-radius: 8px;
  text-decoration: none;
  transition: background-color 0.3s ease;

  &:hover {
    background-color: rgba(255, 255, 255, 0.3);
  }
}

.features-section {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
  width: 100%;
  max-width: 1000px;
  margin-bottom: 3rem;
}

.feature-carousel {
  display: contents; /* 移除轮播容器样式 */
}

.carousel-track {
  display: contents; /* 移除轨道样式 */
}

.feature-card {
  background: rgb(255, 255, 255,0.2);
  //添加模糊玻璃效果
  backdrop-filter: blur(10px);
  border-radius: 12px;
  padding: 1.5rem;
  text-align: center;
  backdrop-filter: blur(10px);
  transition: transform 0.3s ease;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
  
  &:hover {
    transform: scale(1.05) translateY(-5px);
  }
}

// 移除@keyframes scroll动画
.footer {
  position: fixed;
  bottom: 0.5rem;
  right: 2rem;
  // text-align: center;
  font-size: 0.9rem;
  opacity: 0.8;
}

/* 移动端适配 */
@media (max-width: 768px) {
  .home-container {
    padding: 1rem;
    border-radius: 1rem;
  }

  .hero-section {
    h1 {
      font-size: 1.8rem;
    }
    
    p {
      font-size: 1rem;
    }
  }

  .btn-primary {
    padding: 0.6rem 1.2rem;
  }

  .features-section {
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }

  .feature-card {
    padding: 1rem;
    
    &:hover {
      transform: none;
    }
  }

  .footer {
    position: static;
    text-align: center;
    margin-top: 2rem;
  }
}
</style>