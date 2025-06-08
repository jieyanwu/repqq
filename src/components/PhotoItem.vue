<template>
  <div class="photo-item">
    <img :src="photo.url" :alt="photo.caption" class="photo-img">
    <div class="photo-caption" @click="copyImageUrl">{{ photo.caption }}</div>
    <div v-if="showNotification" class="notification">
      图片URL已复制!
    </div>
  </div>
</template>

<script>
export default {
  name: 'PhotoItem',
  props: {
    photo: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      showNotification: false
    }
  },
  methods: {
    async copyImageUrl() {
      try {
        await navigator.clipboard.writeText(this.photo.url);
        this.showNotification = true;
        setTimeout(() => {
          this.showNotification = false;
        }, 2000);
      } catch {
        this.showNotification = true;
        setTimeout(() => {
          this.showNotification = false;
        }, 2000);
      }
    }
  }
}
</script>

<style scoped>
.notification {
  position: fixed;
  bottom: 30px;
  left: 50%;
  transform: translateX(-50%);
  background: rgba(40, 40, 40, 0.9);
  color: #fff;
  padding: 12px 24px;
  border-radius: 8px;
  z-index: 1000;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  font-size: 14px;
  font-weight: 500;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  animation: fadeInOut 2.5s cubic-bezier(0.16, 1, 0.3, 1);
}

@keyframes fadeInOut {
  0% { 
    opacity: 0;
    transform: translateX(-50%) translateY(20px);
  }
  20% { 
    opacity: 1;
    transform: translateX(-50%) translateY(0);
  }
  80% { 
    opacity: 1;
    transform: translateX(-50%) translateY(0);
  }
  100% { 
    opacity: 0;
    transform: translateX(-50%) translateY(-10px);
  }
}
.photo-item {
  position: relative;
  margin-bottom: 20px;
  break-inside: avoid;
  overflow: hidden; 
  border-radius: 16px;
}

.photo-img {
  width: 100%;
  height: auto;
  display: block;
  border-radius: 16px;
  overflow: hidden;
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
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
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  max-height: 20px;
}

.photo-item {
  &:hover {
    .photo-caption {
      transform: translateY(0);
    }
  }
}
</style>