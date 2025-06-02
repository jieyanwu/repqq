<template>
  <div class="love-container">
    <button class="music-control" @click="toggleMusic">
      {{ isPlaying ? '暂停音乐' : '播放音乐' }}
    </button>

    <h1 class="love-title">Our Love Story</h1>

    <!-- 当前播放提示 -->
    <div v-if="currentSongTitle" class="now-playing">
      正在播放：{{ currentSongTitle }}
    </div>

    <!-- 相册墙 -->
    <div class="photo-gallery">
      <div 
        v-for="(photo, index) in photos" 
        :key="index" 
        class="photo-item"
        :style="{ backgroundImage: `url(${photo.url})` }"
      >
        <div class="photo-caption">{{ photo.caption }}</div>
      </div>
    </div>
  </div>
</template>

<script>
import loverUrl from '@/assets/music/lover.m4a'

export default {
  name: 'LoverPage',
  data() {
    return {
      photos: [
          {
            url: 'https://img.picui.cn/free/2025/06/02/683c92147b8a2.jpg',
            caption: '683c92147b8a2.jpg'
          },
          {
            url: 'https://img.picui.cn/free/2025/06/02/683c9214f3e51.jpg',
            caption: '683c9214f3e51.jpg'
          },
          {
            url: 'https://img.picui.cn/free/2025/06/02/683c9215494a6.jpg',
            caption: '683c9215494a6.jpg'
          },
          {
            url: 'https://img.picui.cn/free/2025/06/02/683c92195ae11.png',
            caption: '683c92195ae11.png'
          },
          {
            url: 'https://img.picui.cn/free/2025/06/02/683c9221f2a8f.jpg',
            caption: '683c9221f2a8f.jpg'
          },
          {
            url: 'https://img.picui.cn/free/2025/06/02/683c922b0b497.jpg',
            caption: '683c922b0b497.jpg'
          },
          {
            url: 'https://img.picui.cn/free/2025/06/02/683c92290231e.jpg',
            caption: '683c92290231e.jpg'
          },
          {
            url: 'https://img.picui.cn/free/2025/06/02/683c922b4a749.jpg',
            caption: '683c922b4a749.jpg'
          },
          {
            url: 'https://img.picui.cn/free/2025/06/02/683c9230bced5.jpg',
            caption: '683c9230bced5.jpg'
          },
          {
            url: 'https://img.picui.cn/free/2025/06/02/683c9231d0806.jpg',
            caption: '683c9231d0806.jpg'
          },
          {
            url: 'https://img.picui.cn/free/2025/06/02/683c92319ca1b.jpg',
            caption: '683c92319ca1b.jpg'
          },
          {
            url: 'https://img.picui.cn/free/2025/06/02/683c9233902e3.jpg',
            caption: '683c9233902e3.jpg'
          },
          {
            url: 'https://img.picui.cn/free/2025/06/02/683c923414a16.jpg',
            caption: '683c923414a16.jpg'
          },
          {
            url: 'https://img.picui.cn/free/2025/06/02/683c924a46d92.jpg',
            caption: '683c924a46d92.jpg'
          },
          {
            url: 'https://img.picui.cn/free/2025/06/02/683c92358367b.jpg',
            caption: '683c92358367b.jpg'
          }
        ], 
      audio: null,
      isPlaying: false,
      currentSongTitle: 'Lover'
    };
  },
  mounted() {
    this.audio = new Audio(loverUrl);
    this.audio.loop = true;
    // 浏览器限制：必须由用户交互触发播放
  },
  methods: {
    playAudio() {
      if (this.audio) {
        this.audio.play()
          .catch(e => console.error('播放失败，请先触发用户交互', e));
        this.isPlaying = true;
      }
    },
    pauseAudio() {
      if (this.audio) {
        this.audio.pause();
        this.isPlaying = false;
      }
    },
    toggleMusic() {
      if (this.isPlaying) {
        this.pauseAudio();
      } else {
        this.playAudio();
      }
    }
  },
  beforeUnmount() {
    if (this.audio) {
      this.audio.pause();
      this.audio.src = '';
      this.audio = null;
    }
  }
};
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
  text-shadow: 0 2px 10px rgba(0,0,0,0.3);
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
  box-shadow: 0 10px 20px rgba(0,0,0,0.2);
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
  background: rgba(0,0,0,0.7);
  color: white;
  padding: 1rem;
  transform: translateY(100%);
  transition: transform 0.3s ease;
}

@keyframes pulse {
  0% { transform: scale(1); }
  50% { transform: scale(1.05); }
  100% { transform: scale(1); }
}

.music-control {
  position: fixed;
  bottom: 3rem;
  right: 20px;
  padding: 10px 15px;
  background: rgba(255,255,255,0.8);
  border: none;
  border-radius: 20px;
  cursor: pointer;
  z-index: 100;
  box-shadow: 0 2px 10px rgba(0,0,0,0.2);
  transition: all 0.3s ease;

  &:hover {
    background: white;
    transform: scale(1.05);
  }
}
</style>