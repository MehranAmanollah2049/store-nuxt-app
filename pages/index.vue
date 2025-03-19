<script setup>
import 'swiper/css';
import 'swiper/css/pagination';
import { Pagination, Autoplay } from 'swiper/modules';
import { Swiper, SwiperSlide } from 'swiper/vue';

const { $HttpRequest } = useNuxtApp()

const new_products = ref([]);
const new_products_loading = ref(true)

const discount_products = ref([]);
const discount_products_loading = ref(true)

const popular_products = ref([]);
const popular_products_loading = ref(true)

const fetch_new_products = async () => {
    await $HttpRequest('/new-products')
        .then(res => {
            new_products_loading.value = false
            new_products.value = res
        })
}

const fetch_discount_products = async () => {
    await $HttpRequest('/discount-products')
        .then(res => {
            discount_products_loading.value = false
            discount_products.value = res
        })
}

const fetch_popular_products = async () => {
    await $HttpRequest('/popular-products')
        .then(res => {
            popular_products_loading.value = false
            popular_products.value = res
        })
}

// Function to recall/refresh the requests
const updateLikes = (products, obj) => {
    return products.map(item => {
        if (item.id === obj.id) {
            item.likes = obj.likes;
        }
        return item;
    });
};

const like_tracker = (obj) => {
    new_products.value.data = updateLikes(new_products.value.data, obj);
    discount_products.value.data = updateLikes(discount_products.value.data, obj);
    popular_products.value.data = updateLikes(popular_products.value.data, obj);
};

onMounted(async () => {
    await fetch_new_products()
    await fetch_discount_products()
    await fetch_popular_products()
})

</script>

<template>
    <!-- header -->
    <div class="w-full center max-[550px]:p-5 relative">
        <div
            class="w-full center h-[360px] max-[1090px]:h-[300px] max-[950px]:h-[270px] max-[800px]:h-[210px] max-[600px]:h-[180px] max-[550px]:h-[210px] max-[400px]:h-[170px] relative slider-overflow-visible">
            <ClientOnly>
                <Swiper :modules="[Pagination, Autoplay]" slides-per-view="1" :autoplay="{
                    delay: 5000,
                    disableOnInteraction: false,
                    pauseOnMouseEnter: true
                }" :pagination="{
                    el: '.header-pagination',
                    clickable: true
                }" :breakpoints="{
                    0: {
                        spaceBetween: 10
                    },
                    550: {
                        spaceBetween: 0
                    }
                }" :loop="true" class="w-full h-full">
                    <SwiperSlide>
                        <picture class="w-full h-full">
                            <source media="(max-width: 550px)" srcset="~/assets/image/header-slider/slide-5-sm.jpg" />
                            <img src="~/assets/image/header-slider/slide-5-lg.jpg"
                                class="w-full h-full object-cover max-[550px]:rounded-lg" alt="">
                        </picture>
                    </SwiperSlide>
                    <SwiperSlide>
                        <picture class="w-full h-full">
                            <source media="(max-width: 550px)" srcset="~/assets/image/header-slider/slide-4-sm.jpg" />
                            <img src="~/assets/image/header-slider/slide-4-lg.jpg"
                                class="w-full h-full object-cover max-[550px]:rounded-lg" alt="">
                        </picture>
                    </SwiperSlide>
                    <SwiperSlide>
                        <picture class="w-full h-full">
                            <source media="(max-width: 550px)" srcset="~/assets/image/header-slider/slide-3-sm.jpg" />
                            <img src="~/assets/image/header-slider/slide-3-lg.jpg"
                                class="w-full h-full object-cover max-[550px]:rounded-lg" alt="">
                        </picture>
                    </SwiperSlide>
                </Swiper>
                <div class="pagination-handler header-pagination h-[23px] px-4 absolute bottom-2 z-3 center"></div>
            </ClientOnly>
        </div>
    </div>
    <!-- new products -->
    <div class="w-full center py-15 pb-40 max-[550px]:py-8 max-[550px]:pb-30">
        <div class="w-custom max-[550px]:!w-full center flex-col gap-7">
            <div class="w-full flex items-center justify-start max-[1300px]:px-5">
                <div class="text-title font-fat text-[23px] max-[550px]:text-[21px]">
                    <span
                        class="font-fat text-theme relative after:content-[''] after:absolute after:w-full after:h-[6px] after:bottom-[6px] after:bg-theme-200 after:transform-[skew(-8deg)] after:right-0">
                        جدیدترین
                    </span>
                    محصولات
                </div>
            </div>
            <div
                class="w-full center relative max-[1300px]:overflow-x-auto max-[1300px]:!justify-start scrollbar-hide max-[1300px]:pr-5 max-[1300px]:pl-30">
                <div class="w-full grid grid-cols-5 max-[1300px]:flex max-[1300px]:w-auto">
                    <template v-if="new_products_loading">
                        <ProductCardLoading v-for="index in 5" :key="index" class="max-[1300px]:w-[250px]" />
                    </template>
                    <template v-else>
                        <ProductCard @like_tracker="like_tracker" v-for="product in new_products.data" :key="product.id"
                            :product="product"
                            class="first:rounded-r-xl border-l-transparent last:rounded-l-xl last:border-l-gray-100 max-[1300px]:w-[250px]" />
                    </template>
                </div>
                <nuxt-link :to="{ path: '/products', query: { orderBy: 'news' } }"
                    class="absolute max-[1300px]:relative max-[1300px]:-mr-[153.5px] whitespace-nowrap center gap-1 -left-[92px] px-7 py-1 rounded-t-xl bg-gray-200 text-[#485967] text-[15px] font-bold transform-[rotate(-90deg)]">
                    مشاهده همه
                    <svg class="size-[19px] fill[#485967] transform-[translateY(-1px)]">
                        <use xlink:href="#chevronLeft">
                            <symbol id="chevronLeft" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                                <path
                                    d="M11.414 12l4.293 4.293-1.414 1.414-5-5a1 1 0 010-1.414l5-5 1.414 1.414L11.414 12z">
                                </path>
                            </symbol>
                        </use>
                    </svg>
                </nuxt-link>
            </div>
        </div>
    </div>
    <!-- discount products -->
    <div class="w-full center py-15 relative">
        <div class="w-full center h-[300px] max-[1090px]:h-[430px] bg-theme absolute -z-1 top-0">
            <svg xmlns="http://www.w3.org/2000/svg" id="beast" viewBox="0 0 1000 100" preserveAspectRatio="none"
                class="w-full h-[60px] fill-theme absolute -top-[60px] max-[800px]:w-[calc(100%+100px)]">
                <path d="M500,97C126.7,96.3,0.8,19.8,0,0v100l1000,0V1C1000,19.4,873.3,97.8,500,97z"></path>
            </svg>

            <svg xmlns="http://www.w3.org/2000/svg" id="beast_bottom" viewBox="0 0 1000 100" preserveAspectRatio="none"
                class="w-full h-[60px] fill-theme absolute -bottom-[59px] max-[800px]:w-[calc(100%+100px)]">
                <path class="elementor-shape-fill"
                    d="M1000,4.3V0H0v4.3C0.9,23.1,126.7,99.2,500,100S1000,22.7,1000,4.3z">
                </path>
            </svg>
        </div>
        <div class="w-custom flex items-strech justify-between gap-7 max-[1090px]:flex-col max-[1090px]:!w-full">
            <div
                class="w-3/15 flex items-start justify-start flex-col gap-5 py-5 max-[560px]:py-0 pt-10 max-[1090px]:w-full max-[1090px]:px-3 max-[1090px]:flex-row max-[1090px]:justify-between max-[1090px]:items-center max-[1090px]:pt-0">
                <img src="~/assets/image/diccount-p.svg"
                    class="w-[88%] max-[1090px]:w-[200px] object-contain max-[560px]:w-[160px] max-[355px]:w-[140px]"
                    alt="">
                <nuxt-link to="/products"
                    class="bg-white center rounded-full px-3 py-[5px] pt-[6px] text-title text-[15px]">
                    مشاهده همه
                    <svg class="size-4 fill-title transform-[translateY(-1px)]">
                        <use xlink:href="#chevronLeft">
                            <symbol id="chevronLeft" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                                <path
                                    d="M11.414 12l4.293 4.293-1.414 1.414-5-5a1 1 0 010-1.414l5-5 1.414 1.414L11.414 12z">
                                </path>
                            </symbol>
                        </use>
                    </svg>
                </nuxt-link>
            </div>
            <div
                class="w-12/15 center relative max-[1090px]:w-full max-[950px]:overflow-x-auto max-[1090px]:px-5 max-[950px]:!justify-start scrollbar-hide">
                <div class="w-full grid grid-cols-4 bg-white rounded-xl max-[950px]:flex max-[950px]:w-auto">
                    <template v-if="discount_products_loading">
                        <ProductCardLoading v-for="index in 4" :key="index" class="max-[950px]:w-[250px]" />
                    </template>
                    <template v-else>
                        <ProductCard @like_tracker="like_tracker" v-for="product in discount_products.data"
                            :key="product.id" :product="product"
                            class="first:rounded-r-xl border-l-transparent last:rounded-l-xl last:border-l-gray-100 max-[950px]:w-[250px]" />
                    </template>
                </div>
            </div>
        </div>
    </div>
    <!-- popular products -->
    <div class="w-full center py-15 pb-10 max-[550px]:py-8 max-[550px]:pb-5">
        <div class="w-custom max-[1300px]:!w-full center flex-col gap-7">
            <div class="w-full flex items-center justify-start max-[1300px]:px-5">
                <div class="text-title font-fat text-[23px] max-[1300px]:text-[21px]">
                    <span
                        class="font-fat text-theme relative after:content-[''] after:absolute after:w-full after:h-[6px] after:bottom-[6px] after:bg-theme-200 after:transform-[skew(-8deg)] after:right-0">
                        محبوب ترین
                    </span>
                    محصولات
                </div>
            </div>
            <div
                class="w-full center relative max-[1300px]:overflow-x-auto max-[1300px]:!justify-start scrollbar-hide  max-[1300px]:pr-5 max-[1300px]:pl-30">
                <div class="w-full grid grid-cols-5 max-[1300px]:flex max-[1300px]:w-auto">
                    <template v-if="popular_products_loading">
                        <ProductCardLoading v-for="index in 5" :key="index" class="max-[1300px]:w-[250px]" />
                    </template>
                    <template v-else>
                        <ProductCard @like_tracker="like_tracker" v-for="product in popular_products.data"
                            :key="product.id" :product="product"
                            class="first:rounded-r-xl border-l-transparent last:rounded-l-xl last:border-l-gray-100 max-[1300px]:w-[250px]" />
                    </template>
                </div>
                <nuxt-link :to="{ path: '/products', query: { orderBy: 'populars' } }"
                    class="absolute max-[1300px]:relative max-[1300px]:-mr-[153.5px] whitespace-nowrap center gap-1 -left-[92px] px-7 py-1 rounded-t-xl bg-gray-200 text-[#485967] text-[15px] font-bold transform-[rotate(-90deg)]">
                    مشاهده همه
                    <svg class="size-[19px] fill[#485967] transform-[translateY(-1px)]">
                        <use xlink:href="#chevronLeft">
                            <symbol id="chevronLeft" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                                <path
                                    d="M11.414 12l4.293 4.293-1.414 1.414-5-5a1 1 0 010-1.414l5-5 1.414 1.414L11.414 12z">
                                </path>
                            </symbol>
                        </use>
                    </svg>
                </nuxt-link>
            </div>
        </div>
    </div>
</template>