<template>
  <div class="love-container">


    <h1 class="love-title">Our Love Story</h1>

    <!-- 上传按钮 -->
    <button @click="showModal = true" class="upload-button">
      上传图片
    </button>

    <LoadingSpinner v-if="isLoading" />

    <!-- 上传弹窗 -->
    <div v-if="showModal" class="modal-overlay">
      <div class="modal-content">
        <h3>上传图片URL</h3>
        <input v-model="newImageUrl" placeholder="输入图片URL" class="url-input" />
        <div class="modal-actions">
          <button @click="showModal = false" class="cancel-button">取消</button>
          <button @click="handleUpload" class="confirm-button">确认</button>
        </div>
      </div>
    </div>

    <!-- 当前播放提示 -->
    <!-- <div v-if="currentSongTitle" class="now-playing">
      正在播放：{{ currentSongTitle }}
    </div> -->
    <!-- 相册墙 -->
    <div class="photo-gallery">
      <PhotoItem 
        v-for="(photo, index) in photos" 
        :key="index" 
        :photo="photo" 
      />
    </div>
  </div>
</template>

<script>
import PhotoItem from '@/components/PhotoItem.vue';
import LoadingSpinner from '@/components/LoadingSpinner.vue';

export default {
  name: 'LoverPage',
  components: {
    PhotoItem,
    LoadingSpinner
  },
  data() {
    return {
      showModal: false,
      newImageUrl: '',
      photos: [],
      isLoading: false,
      error: null,
      pagination: {
        page: 1,
        limit: 50,
        total: 0
      }
    };
  },
  async mounted() {
    await this.fetchImages();
    window.addEventListener('scroll', this.handleScroll);
  },
  beforeUnmount() {
    window.removeEventListener('scroll', this.handleScroll);
  },
  methods: {
    async fetchImages() {
      if (this.isLoading) return;
      this.isLoading = true;
      try {
        const { page, limit } = this.pagination;
        const response = await fetch(
          `http://127.0.0.1:5000/api/image?page=${page}&limit=${limit}`
        );
        
        if (!response.ok) throw new Error('获取图片失败');
        
        const data = await response.json();
        this.photos = [...this.photos, ...data.images];
        this.pagination.total = data.total;
        this.pagination.page++;
      } catch (error) {
        this.error = error.message;
      } finally {
        this.isLoading = false;
      }
    },
    handleScroll() {
      const { scrollTop, scrollHeight, clientHeight } = document.documentElement;
      if (scrollTop + clientHeight >= scrollHeight - 200 && !this.isLoading) {
        this.fetchImages();
      }
    },
    async handleUpload() {
      if (!this.newImageUrl) return;
      try {
        await this.uploadImage(this.newImageUrl);
        this.showModal = false;
        this.newImageUrl = '';
      } catch (error) {
        console.error('上传失败:', error);
        this.error = error.message;
      }
    },
    async uploadImage(url) {
      try {
        const response = await fetch('http://127.0.0.1:5000/api/image', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({ url })
        });
        
        if (!response.ok) throw new Error('上传图片失败');
        
        await this.fetchImages(); // 重新加载图片列表
      } catch (error) {
        this.error = error.message;
      }
    }
  }
}
</script>

<style lang="scss" scoped>
@import '@/assets/styles/variables.scss';

.love-container {
  position: relative;
  min-height: 100vh;
  border-radius: 2rem;
  background: $background-color;
  padding: 2rem;
  text-align: center;
}

.love-title {
  font-size: 3rem;
  color: $text-white;
  text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
  margin-bottom: 2rem;
  animation: pulse 2s infinite;
}

.now-playing {
  color: $text-white;
  font-size: 1.2rem;
  margin-bottom: 2rem;
}

.photo-gallery {
  columns: 300px;
  column-gap: 2rem;
  padding: 1rem;
  
  .photo-item {
    display: inline-block;
    width: 100%;
    margin-bottom: 2rem;
  }
}

.upload-button {
  padding: 10px 20px;
  background-color: $upload-button-color;
  color: $text-white;
  border: none;
  border-radius: 20px;
  cursor: pointer;
  font-size: 1rem;
  margin-bottom: 20px;
  transition: background-color $transition-time;

  &:hover {
    background-color: $upload-button-hover;
  }
}

.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.modal-content {
  background: $text-white;
  padding: 2rem;
  border-radius: 10px;
  width: 90%;
  max-width: 500px;
  display: flex;
  flex-direction: column;
  align-items: center;
  
  h3 {
    text-align: center;
    margin-bottom: 1rem;
  }
}

.url-input {
  width: 80%;  // 调整为80%宽度
  margin: 15px auto;  // 使用auto实现水平居中
  padding: 10px;
  margin: 15px 0;
  border: 1px solid #ddd;
  border-radius: 4px;
}

.modal-actions {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
}

.cancel-button {
  padding: 8px 16px;
  background-color: $modal-cancel-color;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.confirm-button {
  padding: 8px 16px;
  background-color: $modal-button-color;
  color: $text-white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}
.loading-container {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  background: rgba(0, 0, 0, 0.5);
  z-index: 1000;
}
// 移除原来的.photo-item和.photo-caption样式
</style>
