<template>
  <div class="card card-carousel overflow-hidden h-100 p-0">
    <div id="carouselExampleCaptions" class="carousel slide h-100" data-bs-ride="carousel">
      <div class="carousel-inner border-radius-lg h-100">
        <div v-for="(slide, index) in slides" :key="index" :class="{ 'carousel-item': true, 'active': index === 0 }" :style="{ backgroundImage: 'url(' + slide.src + ')', backgroundSize: 'cover' }">
          <div class="carousel-caption d-none d-md-block bottom-0 text-start start-0 ms-5">
            <div class="icon icon-shape icon-sm bg-white text-center border-radius-md mb-3">
              <i :class="slide.iconClass + ' text-dark opacity-10'"></i>
            </div>
            <h5 class="text-white mb-1">{{ slide.title }}</h5>
            <p>{{ slide.description }}</p>
          </div>
        </div>
      </div>
      <button class="carousel-control-prev w-5 me-3" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
      </button>
      <button class="carousel-control-next w-5 me-3" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
      </button>
    </div>
  </div>
</template>
<script setup>
const slides = [
  { src: require('@/assets/img/carousel-1.jpg'), iconClass: 'ni ni-camera-compact', title: 'Get started with Argon', description: "There's nothing I really wanted to do in life that I wasn't able to get good at." },
  { src: require('@/assets/img/carousel-2.jpg'), iconClass: 'ni ni-bulb-61', title: 'Faster way to create web pages', description: "That's my skill. I'm not really specifically talented at anything except for the ability to learn." },
  { src: require('@/assets/img/carousel-3.jpg'), iconClass: 'ni ni-trophy', title: 'Share with us your design tips!', description: "Don't be afraid to be wrong because you can't learn anything from a compliment." }
];
</script>