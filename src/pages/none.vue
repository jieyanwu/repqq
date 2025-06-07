<template>
    <div class="timeline-container">
      <div class="timeline">
        <div v-for="(item, index) in timelineItems" :key="index" class="timeline-item">
          <div class="timeline-date">{{ item.date }}</div>
          <div class="timeline-content">
            <h3>{{ item.title }}</h3>
            <p>{{ item.description }}</p>
            <img v-if="item.image" :src="item.image" :alt="item.title" class="timeline-image">
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    name: 'TimelinePage',
    mounted() {
        document.querySelectorAll('.timeline-item').forEach(item => {
            item.style.setProperty('--random-offset', Math.random() * 2);
        });
    },
    data() {
      return {
        timelineItems: [
          {
            date: '2023-01-01',
            title: '事件标题1',
            description: '这里是事件的详细描述文字内容',
            image: require('@/assets/logo.png')
          },
          {
            date: '2023-06-15',
            title: '事件标题2',
            description: '这里是另一个事件的描述',
            image: require('@/assets/logo.png')
          },
          {
            date: '2023-06-15',
            title: '事件标题2',
            description: '这里是另一个事件的描述',
            image: require('@/assets/logo.png')
          },
          {
            date: '2023-06-15',
            title: '事件标题2',
            description: '这里是另一个事件的描述',
            image: require('@/assets/logo.png')
          },
          {
            date: '2023-06-15',
            title: '事件标题2',
            description: '这里是另一个事件的描述',
            image: require('@/assets/logo.png')
          },
          {
            date: '2023-06-15',
            title: '事件标题2',
            description: '这里是另一个事件的描述',
            image: require('@/assets/logo.png')
          },
          {
            date: '2023-06-15',
            title: '事件标题2',
            description: '这里是另一个事件的描述',
            image: require('@/assets/logo.png')
          },
          {
            date: '2023-06-15',
            title: '事件标题2',
            description: '这里是另一个事件的描述',
            image: require('@/assets/logo.png')
          }
          // 可以添加更多时间节点
        ]
      };
    }
  };
  </script>
  
  <style scoped lang="scss">
  .timeline-container {
    min-height: 100vh;
    padding: 4rem 2rem;
    background: linear-gradient(135deg, #c1dcfa 0%, #e8f4fc 100%);
  }
  
  .timeline {
    position: relative;
    max-width: 900px;
    margin: 0 auto;
    padding-bottom: 3rem; // 添加底部内边距确保线到底
    
    &::before {
      content: '';
      position: absolute;
      top: 0;
      bottom: 0;
      left: 50%;
      width: 3px;
      background: linear-gradient(to bottom, #4a90e2, #ff6b6b);
      transform: translateX(-50%);
      z-index: 0; // 确保线在内容下方
    }
  }
  
  .timeline-item {
    position: relative;
    margin-bottom: 3rem;
    z-index: 1; // 确保内容在线之上
    transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    
    &:nth-child(odd) {
      transform: translateX(calc(3rem * var(--random-offset, 1)));
      
      .timeline-content {
        margin-left: 50%;
        padding-left: 2.5rem;
        transform-origin: left center;
      }
    }
    
    &:nth-child(even) {
      transform: translateX(calc(-2rem * var(--random-offset, 1)));
      
      .timeline-content {
        margin-right: 50%;
        padding-right: 2.5rem;
        text-align: right;
        transform-origin: right center;
      }
    }
    
    &:hover {
      transform: translateY(-10px) scale(1.03) !important;
      z-index: 2;
    }
  }
  
  .timeline-content {
    background: white;
    padding: 2rem;
    border-radius: 12px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    clip-path: polygon(
        0% 0%,
        100% 0%,
        100% 85%,
        85% 100%,
        0% 100%
      );
    
    &:hover {
      box-shadow: 0 15px 30px rgba(0,0,0,0.15);
      clip-path: polygon(
        0% 0%,
        100% 0%,
        100% 85%,
        85% 100%,
        0% 100%
      );
    }
  }
  
  .timeline-date {
    position: absolute;
    top: 0;
    left: 50%;
    transform: translateX(-50%);
    background: #4a90e2;
    color: white;
    padding: 0.6rem 1.2rem;
    border-radius: 25px;
    font-size: 1rem;
    font-weight: bold;
    box-shadow: 0 3px 10px rgba(74, 144, 226, 0.3);
    z-index: 1;
  }
  
  .timeline-content {
    background: white;
    padding: 2rem;
    border-radius: 12px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.08);
    transition: box-shadow 0.3s ease;
    
    &:hover {
      box-shadow: 0 8px 25px rgba(0,0,0,0.12);
    }
    
    h3 {
      color: #333;
      margin-bottom: 1rem;
      font-size: 1.4rem;
    }
    
    p {
      color: #666;
      line-height: 1.6;
    }
  }
  
  .timeline-image {
    max-width: 100%;
    height: auto;
    margin-top: 1.5rem;
    border-radius: 8px;
    box-shadow: 0 3px 10px rgba(0,0,0,0.1);
    transition: transform 0.3s ease;
    
    &:hover {
      transform: scale(1.02);
    }
  }
  
  /* 移动端适配 */
  @media (max-width: 768px) {
    .timeline-container {
      padding: 2rem 1rem;
    }
  
    .timeline {
      &::before {
        left: 30px;
        transform: none;
      }
    }
  
    .timeline-item {
      margin-bottom: 2rem;
      
      &:nth-child(odd),
      &:nth-child(even) {
        transform: none;
        
        .timeline-content {
          margin-left: 60px;
          margin-right: 0;
          padding-left: 1.5rem;
          padding-right: 1.5rem;
          text-align: left;
          clip-path: none;  // 新增这行移除裁角效果
        }
      }
      
      &:hover {
        transform: none !important;
      }
    }
  
    .timeline-date {
      left: 30px;
      transform: none;
    }
  
    .timeline-content {
      padding: 1.5rem;
      clip-path: none;  // 确保移除裁角效果
      border-radius: 8px;
      
      &:hover {
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
      }
    }
    
    .timeline-image:hover {
      transform: none;
    }
  }
  </style>
