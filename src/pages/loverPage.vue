<template>
  <div class="love-container">


    <h1 class="love-title">Our Love Story</h1>

    <!-- 上传按钮 -->
    <button @click="showModal = true" class="upload-button">
      上传图片
    </button>

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
      <div v-for="(photo, index) in photos" :key="index" class="photo-item"
        :style="{ backgroundImage: `url(${photo.url})` }">
        <div class="photo-caption">{{ photo.caption }}</div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'LoverPage',
  data() {
    return {
      showModal: false,
      newImageUrl: '',
      photos: [],
      isLoading: false,
      error: null,
      pagination: {
        page: 1,
        limit: 10,
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
  background: linear-gradient(135deg, #ff9a9e 0%, #fad0c4 100%);
  padding: 2rem;
  text-align: center;
}

.love-title {
  font-size: 3rem;
  color: white;
  text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
  margin-bottom: 2rem;
  animation: pulse 2s infinite;
}

.now-playing {
  color: white;
  font-size: 1.2rem;
  margin-bottom: 2rem;
}

.photo-gallery {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 2rem;
  padding: 1rem;
}

.photo-item {
  height: 300px;
  background-size: cover;
  background-position: center;
  border-radius: 16px;
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
  position: relative;
  transition: transform 0.3s ease;
  overflow: hidden;

  &:hover {
    transform: scale(1.05);

    .photo-caption {
      transform: translateY(0);
    }
  }
}

.photo-caption {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: rgba(0, 0, 0, 0.7);
  color: white;
  padding: 1rem;
  transform: translateY(100%);
  transition: transform 0.3s ease;
  white-space: nowrap; /* 禁止换行 */
  overflow: hidden; /* 隐藏溢出内容 */
  text-overflow: ellipsis; /* 显示省略号 */
  max-height: 20px; /* 固定高度 */
}

@keyframes pulse {
  0% {
    transform: scale(1);
  }

  50% {
    transform: scale(1.05);
  }

  100% {
    transform: scale(1);
  }
}

/* 移动端适配 */
@media (max-width: 768px) {
  .love-container {
    padding: 1.5rem;
  }

  .love-title {
    font-size: 2rem;
    margin-bottom: 1.5rem;
  }

  .photo-gallery {
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
    gap: 1.5rem;
    padding: 0.5rem;
  }

  .photo-item {
    height: 200px;
    
    &:hover {
      transform: none;
    }
  }

  .photo-caption {
    padding: 0.8rem;
    font-size: 0.9rem;
  }
}

.upload-button {
  padding: 10px 20px;
  background-color: #ff6b6b;
  color: white;
  border: none;
  border-radius: 20px;
  cursor: pointer;
  font-size: 1rem;
  margin-bottom: 20px;
  transition: background-color 0.3s;

  &:hover {
    background-color: #ff5252;
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
  background: white;
  padding: 2rem;
  border-radius: 10px;
  width: 90%;
  max-width: 500px;
}

.url-input {
  width: 100%;
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

.cancel-button, .confirm-button {
  padding: 8px 16px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.cancel-button {
  background-color: #f1f1f1;
}

.confirm-button {
  background-color: #4a90e2;
  color: white;
}

/* 移动端适配 */
@media (max-width: 768px) {
  .modal-content {
    padding: 1.5rem;
  }

  .love-container {
    padding: 1.5rem;
  }

  .love-title {
    font-size: 2rem;
    margin-bottom: 1.5rem;
  }

  .photo-gallery {
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
    gap: 1.5rem;
    padding: 0.5rem;
  }

  .photo-item {
    height: 200px;
    
    &:hover {
      transform: none;
    }
  }

  .photo-caption {
    padding: 0.8rem;
    font-size: 0.9rem;
  }
}
</style>