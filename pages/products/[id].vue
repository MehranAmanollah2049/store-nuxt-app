<script setup>

import 'swiper/css';
import 'swiper/css/pagination';
import { Pagination, Autoplay } from 'swiper/modules';
import { Swiper, SwiperSlide } from 'swiper/vue';
import toast from 'vue-toast-next';
import { useUser } from '~/stores/auth/useUser';

// fetching
const { start, finish } = useLoadingIndicator()
const userStore = useUser()
const route = useRoute();
const { $HttpRequest } = useNuxtApp()

const product = ref({
    types: [],
    category: {},
    brand: {},
});

const is_product_loading = ref(true)

const fetch_data = async () => {
    await $HttpRequest(`/products/${route.params.id}`)
        .then(res => {
            is_product_loading.value = false
            product.value = res
        })
}

// data types
const type_index = ref(0)

const current_type = computed(() => product.value.types[type_index.value])

onMounted(async () => {
    await fetch_data()

    if (route.query.type) {
        type_index.value = product.value.types.findIndex(item => item.id == route.query.type)
    }

})

const images = computed(() => product.value.types.map(item => ({
    id: item.id,
    image: item.image,
})))


// loadings
let cart_loading = ref(false)

// methods
const add_cart = () => {
    if (!userStore.isLoggedIn()) {
        return toast.error("ابتدا وارد حساب خود شوید")
    }

    if (current_type.value.count <= 0) {
        return toast.error("متاسفانه از این کالا در انبار موجودی نداریم")
    }

    if (!cart_loading.value) {
        cart_loading.value = true;
        start()

        $HttpRequest(`/cart/${current_type.value.id}`, {
            method: 'POST'
        })
            .then(res => {
                cart_loading.value = false
                finish()
                if (res) {
                    current_type.value.cart_user = res.data
                    userStore.increase_cart()
                    toast.success("کالای موردنظر به سبد خرید اضافه شد")
                }
            })
            .catch(err => {
                finish()
                cart_loading.value = false
            })
    }
}


const next_handler = () => {
    if (!userStore.isLoggedIn()) {
        return toast.error("ابتدا وارد حساب خود شوید")
    }

    if (!current_type.value.cart_user) {
        return toast.error("امکان اجرای این عملیات وجود ندارد")
    }

    let new_count = current_type.value.cart_user.count + 1;

    if (new_count > current_type.value.count) {
        return toast.error("متاسفانه به این مقدار در انبار موجودی نداریم")
    }

    if (!cart_loading.value) {
        cart_loading.value = true;
        start()

        $HttpRequest(`/cart/${current_type.value.cart_user.id}/increase`, {
            method: 'POST'
        })
            .then(res => {
                cart_loading.value = false
                finish()
                if (res) {
                    current_type.value.cart_user.count = res.count
                }
            })
            .catch(err => {
                cart_loading.value = false
                finish()
            })
    }
}

const prev_handler = () => {
    if (!userStore.isLoggedIn()) {
        return toast.error("ابتدا وارد حساب خود شوید")
    }

    if (!current_type.value.cart_user) {
        return toast.error("امکان اجرای این عملیات وجود ندارد")
    }

    if (!cart_loading.value) {
        cart_loading.value = true;
        start()

        $HttpRequest(`/cart/${current_type.value.cart_user.id}/decrease`, {
            method: 'POST'
        })
            .then(res => {
                cart_loading.value = false
                finish()
                if (res) {

                    if (!res.is_deleted) {
                        current_type.value.cart_user.count = res.count
                    }
                    else {
                        current_type.value.cart_user = null;
                        userStore.decrease_cart()
                        toast.warning("کالای موردنظر از سبد خرید حذف شد")
                    }
                }
            })
            .catch(err => {
                cart_loading.value = false
                finish()
            })
    }
}


</script>

<template>
    <div class="w-full center pt-15 max-[900px]:pt-3">
        <div
            class="w-custom max-[1350px]:!w-[92%] flex items-start justify-between max-[900px]:flex-col max-[900px]:items-center">
            <div
                class="w-11/35 h-[360px] relative max-[1080px]:w-13/35 max-[1000px]:w-14/35 max-[900px]:w-[400px] max-[550px]:w-full max-[550px]:h-[280px]">
                <template v-if="!is_product_loading">
                    <ClientOnly>
                        <Swiper :modules="[Pagination, Autoplay]" slides-per-view="1" :autoplay="{
                            delay: 5000,
                            disableOnInteraction: false,
                            pauseOnMouseEnter: true
                        }" :initial-slide="type_index" :pagination="{
                            el: '.header-pagination',
                            clickable: true
                        }" class="w-full h-full">
                            <SwiperSlide v-for="item in images" :key="item.id">
                                <NuxtImg lazy="true" :src="useRuntimeConfig().public.BASEURL + item.image"
                                    class="w-full h-full object-contain max-[550px]:rounded-lg" alt="" />
                            </SwiperSlide>
                        </Swiper>
                        <div class="w-full flex items-center justify-center absolute bottom-4 z-3">
                            <div
                                class="pagination-handler !w-auto bg-[#00000021] rounded-full header-pagination h-[20px] px-2 center">
                            </div>
                        </div>
                    </ClientOnly>
                </template>
                <template v-else>
                    <div class="w-full h-full bg-gray-200 rounded-2xl animation-pluse"></div>
                </template>
            </div>
            <div class="w-23/35 max-[1080px]:w-21/35 max-[1000px]:w-20/35 max-[900px]:w-full max-[900px]:mt-2">
                <div class="w-full flex items-center justify-start gap-1">
                    <nuxt-link to="/products" class="text-blue-500 font-medium text-[14px]">فروشگاه</nuxt-link>
                    <span class="text-gray-300">/</span>
                    <template v-if="!is_product_loading">
                        <nuxt-link :to="{ path: '/products', query: { category: product.category.id } }"
                            class="text-blue-500 font-medium text-[14px]">{{ product.category.title }}</nuxt-link>
                        <span class="text-gray-300">/</span>
                        <nuxt-link :to="{ path: '/products', query: { brand: product.brand.id } }"
                            class="text-blue-500 font-medium text-[14px]">{{ product.brand.title }}</nuxt-link>
                    </template>
                    <template v-else>
                        <div class="w-[30px] h-[10px] rounded-full bg-gray-200 animation-pluse"></div>
                        <span class="text-gray-300">/</span>
                        <div class="w-[30px] h-[10px] rounded-full bg-gray-200 animation-pluse"></div>
                    </template>
                </div>
                <template v-if="!is_product_loading">
                    <p class="w-full text-right font-bold text-title text-[20px] py-1 max-[550px]:text-[19px]">{{
                        product.title }}</p>
                </template>
                <template v-else>
                    <p class="w-full h-[13px] bg-gray-200 animation-pluse rounded-full mt-5"></p>
                    <p class="w-[40%] h-[13px] bg-gray-200 animation-pluse rounded-full mt-3 mb-5"></p>
                </template>

                <div class="w-full flex items-center justify-between relative mt-2">
                    <div class="bg-white flex items-center justify-start gap-2 relative z-1 pl-4">
                        <template v-if="!is_product_loading">
                            <div class="h-[25px] center text-[13px] font-medium text-gray-400 gap-1">
                                <svg xmlns="http://www.w3.org/2000/svg"
                                    class="size-[13px] transform-[translateY(-2px)] fill-orange-600" viewBox="0 0 24 24"
                                    width="512" height="512">
                                    <path
                                        d="M1.327,12.4,4.887,15,3.535,19.187A3.178,3.178,0,0,0,4.719,22.8a3.177,3.177,0,0,0,3.8-.019L12,20.219l3.482,2.559a3.227,3.227,0,0,0,4.983-3.591L19.113,15l3.56-2.6a3.227,3.227,0,0,0-1.9-5.832H16.4L15.073,2.432a3.227,3.227,0,0,0-6.146,0L7.6,6.568H3.231a3.227,3.227,0,0,0-1.9,5.832Z" />
                                </svg>
                                {{ product.rate.rate }}
                                ({{ product.rate.total }})
                            </div>

                            <div
                                class="h-[25px] bg-gray-200/70 text-title text-[13px] center px-2 pt-[1px] rounded-full cursor-pointer font-medium">
                                {{ product.total_cmt }} دیدگاه
                                <svg xmlns="http://www.w3.org/2000/svg"
                                    class="size-[13px] transform-[translateY(-0.5px)] fill-title" viewBox="0 0 24 24"
                                    width="512" height="512">
                                    <path
                                        d="M10.6,12.71a1,1,0,0,1,0-1.42l4.59-4.58a1,1,0,0,0,0-1.42,1,1,0,0,0-1.41,0L9.19,9.88a3,3,0,0,0,0,4.24l4.59,4.59a1,1,0,0,0,.7.29,1,1,0,0,0,.71-.29,1,1,0,0,0,0-1.42Z" />
                                </svg>
                            </div>

                            <div class="h-[25px] text-[13px] center px-2 pt-[1px] rounded-full cursor-pointer font-medium"
                                :class="{
                                    'bg-[#e9edff] text-[#4a6dff]': current_type.count > 10,
                                    'bg-[#ed194311] text-[#ed1944]': current_type.count <= 10,
                                }">
                                <template v-if="current_type.count > 0">
                                    {{ current_type.count }} عدد موجودی
                                </template>
                                <template v-else>عدم موجودی</template>
                            </div>
                        </template>
                        <template v-else>
                            <div class="w-[50px] h-[10px] bg-gray-200 rounded-full animation-pluse"></div>
                            <div class="w-[50px] h-[10px] bg-gray-200 rounded-full animation-pluse"></div>
                            <div class="w-[50px] h-[10px] bg-gray-200 rounded-full animation-pluse"></div>
                        </template>
                    </div>
                    <div class="w-full h-[1px] bg-gray-200/60 absolute left-0"></div>
                    <div class="bg-white pr-4 center relative z-1 transform-[translateY(-1px)]">
                        <template v-if="!is_product_loading">
                            <LikeProduct v-model="product.likes" :product_id="product.id" />
                        </template>
                        <template v-else>
                            <div class="w-[50px] h-[10px] bg-gray-200 rounded-full animation-pluse"></div>
                        </template>
                    </div>
                </div>

                <div class="w-full flex items-start justify-center flex-col gap-2 my-7">
                    <p class="text-[16px] font-bold text-title">ویژگی ها:</p>
                    <div class="w-full flex items-center justify-start gap-4 flex-wrap">
                        <template v-if="!is_product_loading">
                            <Property v-for="(property, index) in product.propertys" :key="index" :title="property" />
                        </template>
                        <template v-else>
                            <div class="w-[60px] h-[10px] bg-gray-200 rounded-full animation-pluse"></div>
                            <div class="w-[60px] h-[10px] bg-gray-200 rounded-full animation-pluse"></div>
                            <div class="w-[60px] h-[10px] bg-gray-200 rounded-full animation-pluse"></div>
                            <div class="w-[60px] h-[10px] bg-gray-200 rounded-full animation-pluse"></div>
                        </template>
                    </div>
                </div>

                <div class="w-full flex items-start justify-center flex-col gap-2 my-7">
                    <p class="text-[16px] font-bold text-title">رنگ بندی ها:</p>
                    <div class="w-full flex items-center justify-start gap-3 flex-wrap">
                        <template v-if="!is_product_loading">
                            <ColorItem
                                v-for="(item, index) in product.types.map(type => ({ id: type.id, title: type.color_title, color: type.color_code }))"
                                :key="item.id" :data="item" :index="index" v-model="type_index" />
                        </template>
                        <template v-else>
                            <div class="flex items-center justify-start gap-2 mt-2">
                                <div class="size-[30px] rounded-full bg-gray-200 animation-pluse"></div>
                                <p class="w-[40px] h-[10px] bg-gray-200 animation-pluse rounded-full"></p>
                            </div>
                            <div class="flex items-center justify-start gap-2 mt-2">
                                <div class="size-[30px] rounded-full bg-gray-200 animation-pluse"></div>
                                <p class="w-[40px] h-[10px] bg-gray-200 animation-pluse rounded-full"></p>
                            </div>
                        </template>
                    </div>
                </div>

                <div class="w-full flex items-center justify-between pt-3">
                    <template v-if="!is_product_loading">
                        <template v-if="userStore.isLoggedIn() && current_type.cart_user">
                            <CartCounter @next="next_handler" @prev="prev_handler" :count="current_type.cart_user.count"
                                :total="current_type.count" :loading="cart_loading" />
                        </template>
                        <template v-else>
                            <div class="btn-theme center group transition-custom px-5" @click="add_cart" :class="{
                                'pointer-events-none bg-theme': cart_loading
                            }">
                                <Loading v-if="cart_loading" theme="white" />
                                <template v-else>
                                    <svg xmlns="http://www.w3.org/2000/svg"
                                        class="size-[17px] fill-white transform-[translateY(0.4px)] transition-custom group-hover:fill-theme"
                                        viewBox="0 0 24 24" width="512" height="512">
                                        <circle cx="7" cy="22" r="2" />
                                        <circle cx="17" cy="22" r="2" />
                                        <path
                                            d="M23,3H21V1a1,1,0,0,0-2,0V3H17a1,1,0,0,0,0,2h2V7a1,1,0,0,0,2,0V5h2a1,1,0,0,0,0-2Z" />
                                        <path
                                            d="M21.771,9.726a.994.994,0,0,0-1.162.806A3,3,0,0,1,17.657,13H5.418l-.94-8H13a1,1,0,0,0,0-2H4.242L4.2,2.648A3,3,0,0,0,1.222,0H1A1,1,0,0,0,1,2h.222a1,1,0,0,1,.993.883l1.376,11.7A5,5,0,0,0,8.557,19H19a1,1,0,0,0,0-2H8.557a3,3,0,0,1-2.829-2H17.657a5,5,0,0,0,4.921-4.112A1,1,0,0,0,21.771,9.726Z" />
                                    </svg>
                                    افزودن به سبد خرید
                                </template>
                            </div>
                        </template>
                    </template>
                    <template v-else>
                        <div class="w-[80px] h-[13px] bg-gray-200 animation-pluse rounded-full"></div>
                    </template>

                    <div class="flex h-[50px] items-end justify-center flex-col">
                        <template v-if="!is_product_loading">
                            <div class="center gap-[7px] -mb-[3px]" v-if="current_type.discount">
                                <p
                                    class="text-[15.5px] text-gray-400/80 font-medium line-through transform-[translateY(0.5px)]">
                                    {{ current_type.price }}</p>
                                <div
                                    class="h-[20px] bg-theme rounded-[50px] px-2 pt-[0.7px] text-white center text-[13px] font-bold shadow-theme-200">
                                    <span class="font-bold -mb-[1.2px]">%</span> {{ current_type.discount }}
                                </div>
                            </div>
                            <div class="center gap-1 text-title font-bold text-[23px]">
                                {{ current_type.payment }}
                                <svg xmlns="http://www.w3.org/2000/svg" data-name="Layer 2" viewBox="0 0 51.29 27.19"
                                    width="51" height="27" class="fill-gray-400 w-5 h-5">
                                    <path
                                        d="M36.48 22.85c1.78-.83 2.93-1.81 3.45-2.94h-1.65c-2.53 0-4.69-.66-6.47-1.97-.59.68-1.23 1.2-1.93 1.55s-1.54.53-2.5.53c-1.03 0-1.87-.18-2.51-.53-.65-.35-1.14-.96-1.5-1.83-.35-.87-.56-2.08-.63-3.62-.02-.28-.04-.6-.04-.97s-.01-.72-.04-1.07c-.14-3.42-.28-6.26-.42-8.51l-5.8 1.37c.73 1.64 1.34 3.34 1.83 5.08.49 1.75.74 3.58.74 5.5 0 1.6-.37 3.12-1.11 4.57-.74 1.46-1.85 2.64-3.32 3.57-1.48.93-3.27 1.39-5.38 1.39s-3.82-.45-5.21-1.34C2.61 22.74 1.6 21.6.96 20.22c-.63-1.38-.95-2.84-.95-4.36 0-1.2.13-2.28.4-3.25.27-.97.63-1.93 1.07-2.87l2.39 1.34c-.38.92-.65 1.71-.83 2.39-.18.68-.26 1.48-.26 2.39 0 1.76.49 3.19 1.48 4.29s2.63 1.65 4.92 1.65c1.55 0 2.87-.32 3.96-.95 1.09-.63 1.9-1.44 2.43-2.43.53-.98.79-1.98.79-2.99 0-2.65-.82-5.82-2.46-9.5l1.69-3.52L22.38.79c.16-.05.39-.07.67-.07.54 0 .98.19 1.32.56s.53.88.58 1.51c.14 2.04.27 5.02.39 8.94.02.38.04.75.04 1.13s.01.71.04 1.02c.05 1.03.22 1.78.53 2.25s.81.7 1.51.7c.84 0 1.52-.18 2.04-.53.52-.35.97-1 1.37-1.93.75-1.71 1.33-2.96 1.74-3.75.41-.79.94-1.46 1.58-2.04.64-.57 1.44-.86 2.37-.86 1.83 0 3.27.94 4.31 2.83s1.69 4.06 1.95 6.53c1.57-.02 2.77-.13 3.61-.33.83-.2 1.41-.49 1.72-.88.32-.39.47-.89.47-1.5 0-.75-.16-1.67-.49-2.76-.33-1.09-.69-2.1-1.09-3.04l2.43-1.23c1.22 3.1 1.83 5.44 1.83 7.04 0 1.83-.67 3.18-2 4.04-1.34.87-3.53 1.34-6.58 1.41-.49 2.21-1.8 3.93-3.92 5.19-2.12 1.25-4.68 1.98-7.69 2.16l-1.2-2.88c2.6-.14 4.8-.63 6.58-1.46ZM10.38 5.66l.11 3.31-3.2.28-.46-3.31 3.55-.28Zm25.1 10.83c.88.28 1.81.42 2.8.42h1.93c-.16-1.67-.55-3.08-1.16-4.26-.61-1.17-1.38-1.76-2.32-1.76-.75 0-1.42.45-2.02 1.34-.6.89-1.11 1.92-1.53 3.1.66.49 1.42.88 2.3 1.16ZM43.64.21C45.06.07 46.43 0 47.74 0c.96 0 1.67.02 2.11.07l-.21 2.81c-.42-.05-1.08-.07-1.97-.07-1.2 0-2.44.07-3.73.21s-2.44.32-3.45.53L39.86.81c1.1-.26 2.36-.46 3.78-.6Z"
                                        data-name="Layer 1"></path>
                                </svg>
                            </div>
                        </template>
                        <template v-else>
                            <div class="w-[50px] h-[10px] rounded-full bg-gray-200 animation-pluse mb-2"></div>
                            <div class="w-[80px] h-[10px] rounded-full bg-gray-200 animation-pluse"></div>
                        </template>
                    </div>
                </div>
                <StarRating v-model="product.rate" :loading="is_product_loading" />
                <CommentSection />
            </div>
        </div>
    </div>
</template>