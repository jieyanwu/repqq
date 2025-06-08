<template>
  <ul class="list-head">
    <li>
      <router-link to="/" class="router-link">首页</router-link>
    </li>
    <li>
      <router-link to="/repcqqweb" class="router-link">QQ商店</router-link>
    </li>
    <li>
      <router-link to="/love" class="router-link">情人相册</router-link>
    </li>
    <li>
      <router-link to="/timeline" class="router-link">TimeLine</router-link>
    </li>
    <!-- <li>
      <router-link to="/login" class="router-link">登录/注册</router-link>
    </li> -->
  </ul>
  <div class="music-controls">
    <span>{{ songs[currentSongIndex].title }}</span>
    <div class="gr">
        <button @click="prevSong" class="music-btn">上</button>
        <button @click="toggleMusic" class="music-btn">
          {{ isPlaying ? '⏸︎' : '▶︎' }}
        </button>
        <button @click="nextSong" class="music-btn">下</button>
    </div>
    
  </div>
  <router-view></router-view>
</template>

<script>
// import { RouterView } from 'vue-router';
export default {
  name: 'App',
  data() {
    return {
      datas: [],
      audio: null,
      isPlaying: false,
      currentSongIndex: 1,
      songs: [
        { title: 'Lover', url: require('@/assets/music/lover.flac') },
        { title: 'Exile', url: require('@/assets/music/exile.flac') },
        { title: 'Falling UP', url: require('@/assets/music/FallingUP.flac') }
      ]
    }
  },
  mounted() {
    this.audio = new Audio();
    this.audio.loop = true;
    // 添加ended事件监听实现无限循环
    this.audio.addEventListener('ended', this.handleSongEnded);
},
methods: {
    playAudio() {
      if (this.audio) {
        this.audio.src = this.songs[this.currentSongIndex].url;
        this.audio.play()
          .catch(e => console.error('播放失败', e));
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
    },
    handleSongEnded() {
        this.nextSong();
    },
    nextSong() {
        this.currentSongIndex = (this.currentSongIndex + 1) % this.songs.length;
        this.playAudio();
    },
    prevSong() {
        this.currentSongIndex = (this.currentSongIndex - 1 + this.songs.length) % this.songs.length;
        this.playAudio();
    }
},
beforeUnmount() {
    if (this.audio) {
        this.audio.removeEventListener('ended', this.handleSongEnded);
        this.audio.pause();
        this.audio.src = '';
        this.audio = null;
    }
}
}
</script>
<style scoped lang="scss">
// 修改为相对路径
@import "@/assets/styles/variables.scss";
@import '@/assets/styles/colors/blue.scss';

* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

html {
  font-size: $font-size-base;
}

body {
  background-color: $background-color;
  color: $text-color;
  font-family: $font-family;
  line-height: $line-height-base;
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
  background-color: #f3f3f3;
  border-radius: 12px;
  box-shadow: $shadow;
  margin-bottom: 2rem;

  li {
    margin: 0.5rem 0.75rem;
    padding: 0.5rem 1rem;
    background-color: $theme-color !important; // 强制使用主题色
    color: white !important; // 强制使用白色文字
    border-radius: 8px;
    font-size: 1rem;
    transition: background-color $transition-time;

    &:hover {
      background-color: darken($theme-color, 10%) !important; // 强制使用暗色变体
      cursor: pointer;
    }
  }
}

.head {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-bottom: 2rem;
}
.music-control {
  position: fixed;
  bottom: 3rem;
  right: 20px;
  padding: 10px 15px;
  background: rgba(255, 255, 255, 0.8);
  border: none;
  border-radius: 20px;
  cursor: pointer;
  z-index: 100;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
  transition: all 0.3s ease;
  &:hover {
    background: white;
    transform: scale(1.05);
  }
}
.router-link {
  color: white;
  text-decoration: none; // 取消默认的下划线
  &:hover {
    text-decoration: underline; // 悬停时显示下划线
  }
  // 取消点击时的下划线
  &:active,
  &:focus {
    text-decoration: none;
  }
}

.music-controls {
  position: fixed;
  bottom: 2.5rem;
  right: 2rem;
  display: flex;
  align-items: center;
  flex-direction: column;
  gap: 0.5rem;
  z-index: 100;
  span{
    display: flex;
    align-items: center;
    justify-content: center;
    height: 2rem;
    padding: 0.5rem 1rem;
    border-radius: 20px;
    font-size: 1rem;
    margin-bottom: 0.5rem;
    color: white;
    text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
    background: #f3f3f3;// 使用主题变量
    // box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
    animation: pulse 2s infinite;
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
    @media (max-width: 768px) {
      font-size: 0.9rem;
    }
  }
  .gr{
    .music-btn {
      margin: 0.2rem;
      padding: 0.5rem 1rem;
      background: rgba(255, 255, 255, 0.8);
      border: none;
      border-radius: 20px;
      cursor: pointer;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
      transition: all 0.3s ease;

      &:hover {
        background: white;
        transform: scale(1.05);
      }
    }
  }
  
}



/* 移动端适配 */
@media (max-width: 768px) {
  .list-head {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 0.5rem;
    padding: 0.5rem;
    
    li {
      margin: 0.3rem 0;
      padding: 0.8rem;
      text-align: center;
      width: 100%;
    }
  }
}
</style>
