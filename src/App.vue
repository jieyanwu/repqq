<template>
  <ul class="list-head">
    <li>
      <router-link to="/" class="router-link">首页</router-link>
    </li>
    <li>
      <router-link to="/repcqqweb" class="router-link">QQ重置</router-link>
    </li>
    <li>
      <router-link to="/love" class="router-link">情人相册</router-link>
    </li>
  </ul>
    <router-view></router-view>
</template>

<script>
// import { RouterView } from 'vue-router';


export default {
  name: 'App',

  data () {
    return {
      datas: [],
     
    }
  },
 
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
  background-color: #fff;
  border-radius: 12px;
  box-shadow: $shadow;
  margin-bottom: 2rem;

  li {
    margin: 0.5rem 0.75rem;
    padding: 0.5rem 1rem;
    background-color: $theme-color;
    color: white;
    border-radius: 8px;
    font-size: 1rem;
    transition: background-color $transition-time;

    &:hover {
      background-color: $link-hover-color;
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
</style>