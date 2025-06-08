<template>
  <div class="app-container">
    <div class="search">
      <h1><a href="https://pc.qq.com" target="_blank" style="color: var(font-size-base);text-decoration: none;color: aliceblue;">腾讯软件中心</a></h1>
      <p>此网站在 pc.qq.com 获取接口并获取数据</p>
      <p v-if="this.datas[0]">当前版本：{{ datas[0]?.ver }}</p>
      <p v-else>当前版本：0.0.0</p>
      <div class="search-controls">
        <input type="text" v-model="searchKeyword" placeholder="搜索..." @keyup.enter="handleSearch"
          class="search-input" />
        <button @click="handleSearch" class="search-button">搜索</button>
      </div>
    </div>
    <!-- 数据为空时的占位 -->
    <div v-if="datas.length === 0" class="loading-placeholder">
      <LoadingSpinner v-if="isLoading" />
      <div v-else>暂无数据</div>
    </div>
    <!-- 主体内容 -->
    <div v-else class="full-content">
      <section class="container">
        <AppList :datas="datas" />
      </section>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import AppList from '@/components/AppList.vue';
import LoadingSpinner from '@/components/LoadingSpinner.vue';

export default {
  name: 'ReApp',
  components: {
    AppList,
    LoadingSpinner
  },
  data() {
    return {
      datas: [],
      limit: 42,
      page: 1,
      isLoading: false,
      searchKeyword: ''
    };
  },
  mounted() {
    this.fetchData();
    window.addEventListener('scroll', this.handleScroll);
  },
  beforeUnmount() {
    window.removeEventListener('scroll', this.handleScroll);
  },
  methods: {
    async fetchData() {
      if (this.isLoading) return;
      this.isLoading = true;
      try {
        const url = `http://127.0.0.1:5000/api/softdata?limit=${this.limit}&page=${this.page}`;
        const response = await axios.get(url);
        // this.datas = []
        this.datas = this.datas.concat(response.data);
        this.page++;
      } catch (error) {
        console.error('数据获取失败:', error);
      } finally {
        this.isLoading = false;
      }
    },
    handleScroll() {
      const { scrollTop, scrollHeight, clientHeight } = document.documentElement;
      if (scrollTop + clientHeight >= scrollHeight - 200) {
        this.fetchData();
      }
    },
    async handleSearch() {
      if (this.isLoading) return;
      this.isLoading = true;
      try {
        const url = `http://127.0.0.1:5000/api/softdata/search?keyword=${this.searchKeyword}`;
        const response = await axios.get(url);
        this.datas = response.data.results || [];
        this.page = 1;
      } catch (error) {
        console.error('搜索失败:', error);
        this.datas = [];
      } finally {
        this.isLoading = false;
      }
    }
  }
};
</script>

<style scoped lang="scss">
@import "@/assets/styles/variables.scss";
// @import '@/assets/styles/colors/blue.scss';

*{
  color: $text-color !important;
}

.app-container {
  background: $background-color;
  min-height: 100vh;
  border-radius: 2rem;
  color: white;
  padding: 2rem 1rem;
  display: flex;
  flex-direction: column;
  align-items: center;
}


// 移除以下样式
// .loading-spinner {
//   display: inline-block;
//   width: 20px;
//   height: 20px;
//   border: 3px solid rgba(255,255,255,0.3);
//   border-radius: 50%;
//   border-top-color: white;
//   animation: spin 1s ease-in-out infinite;
//   margin-right: 10px;
//   
//   + span {
//     animation: none;
//   }
// }

// @keyframes spin {
//   to { transform: rotate(360deg); }
// }
.full-content {
  width: 100%;
  max-width: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
}
.search {
  text-align: center;
  margin-bottom: 2rem;
  width: 100%;
  max-width: 800px;
}

.search-controls {
  display: flex;
  justify-content: center;
  gap: 0.5rem;
  margin-top: 1rem;
}

.search-input {
  padding: 8px 12px;
  border: 1px solid rgba(0, 0, 0, 0.6);
  border-radius: 4px;
  font-size: 14px;
  width: 200px;
  color: $text-white;
  background: $search-input-bg;
  background-color: rgba(255, 255, 255, 0.4);

  &:focus {
    outline: none;
    border-color: $text-white;
    box-shadow: 0 0 0 2px rgba($text-white, 0.3);
  }
}

.search-button {
  padding: 8px 16px;
  background-color: $button-bg;
  color: $text-white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;

  &:hover {
    background-color: $search-input-hover;
  }
}

.container {
  width: 100%;
  max-width: 100%;
  padding: 0 1rem;
  box-sizing: border-box;
}

/* 移动端适配 */
@media (max-width: 768px) {
  .app-container {
    padding: 1rem;
    border-radius: 1rem;
  }

  .search {
    margin-bottom: 1rem;
    
    h1 {
      font-size: 1.5rem;
    }
    
    p {
      font-size: 0.9rem;
    }
  }

  .search-controls {
    flex-direction: column;
    align-items: center;
  }

  .search-input {
    width: 100%;
    max-width: 300px;
  }

  .search-button {
    width: 100%;
    max-width: 300px;
    margin-top: 0.5rem;
  }

  .container {
    padding: 0;
  }
}
</style>