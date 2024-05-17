<template>
  <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" style="height:88%; margin: 0">
    <ol class="carousel-indicators">
      <li v-for="(slide, index) in slides" :key="index" :data-target="carouselExampleIndicators" :data-slide-to="index" :class="{ active: index === currentIndex }"></li>
    </ol>
    <div class="carousel-inner" style="height: 100%;margin-bottom: 0px;">
      <div class="carousel-item" :class="{ active: index === currentIndex }" v-for="(slide, index) in slides" :key="index" style="height:100%">
        <img
          style="height: 100%; border-radius: 15px;"
          :src="slide.src" class="d-block w-100" :alt="'slide-' + (index + 1)">
      </div>
    </div>
    <a class="carousel-control-prev" href="#" role="button" @click.prevent="prevSlide">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#" role="button" @click.prevent="nextSlide">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
</template>

<script setup>
import { ref } from 'vue';

const slides = [
  { src: require('../../assets/img/team-1.jpg') },
  { src: require('../../assets/img/team-2.jpg') },
  { src: require('../../assets/img/team-3.jpg') }
];
const currentIndex = ref(0);

const prevSlide = () => {
  currentIndex.value = (currentIndex.value - 1 + slides.length) % slides.length;
  resetSlideInterval();
};

const nextSlide = () => {
  currentIndex.value = (currentIndex.value + 1) % slides.length;
  resetSlideInterval();
};

// 자동으로 슬라이드 변경을 위한 타이머 설정
let slideInterval = setInterval(nextSlide, 5000);

// 사용자가 수동으로 슬라이드를 변경할 때 타이머 재설정
const resetSlideInterval = () => {
  clearInterval(slideInterval);
  slideInterval = setInterval(nextSlide, 5000);
};

</script>