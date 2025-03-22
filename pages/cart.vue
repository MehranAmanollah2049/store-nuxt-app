<script setup>
import toast from 'vue-toast-next'


const { $HttpRequest } = useNuxtApp()

const products = ref({
    data: []
})
const products_loading = ref(true);

const fetch_data = async () => {
    await $HttpRequest(`/cart`)
        .then(res => {
            products_loading.value = false
            products.value = res
        })
}

const delete_cart = (id) => {
    products.value.data = products.value.data.filter(item => item.id != id)
}

let available_carts = computed(() => products.value?.data?.filter(cart => cart.count <= cart.total) || [])

let total_price = computed(() => {
    return available_carts?.value.reduce((total, current) => {
        if (current.price) {
            return total + (current.price * current.count);
        }
        else {
            return total + (current.payment * current.count);
        }
    }, 0);
})

let total_discount = computed(() => {
    return available_carts?.value.reduce((total, current) => {
        if (current.discount) {
            return total + ((current.price - current.payment) * current.count);
        }

        return total
    }, 0);
})

let total_payment = computed(() => {
    return available_carts?.value.reduce((total, current) => {
        return total + (current.payment * current.count);
    }, 0);
})

const { start, finish } = useLoadingIndicator()
let isLoading = ref(false)

const payment = () => {
    if (!isLoading.value) {
        isLoading.value = true
        start()

        $HttpRequest('/payment', {
            method: 'POST'
        })
            .then(res => {
                isLoading.value = false;
                finish()

                if (res) {

                    toast.loading("در حال انتقال به درگاه")

                    window.location.href = JSON.parse(res).action
                }
            })
            .catch(err => {
                isLoading.value = false;
                finish()
            })
    }
}

onMounted(async () => await fetch_data())

</script>

<template>
    <div class="w-full center py-10">
        <div class="w-custom px-10 center flex-col gap-6 max-[1350px]:px-0">
            <p class="w-full font-heavy text-title text-[25px]">سبد خرید</p>
            <div class="w-full flex items-start justify-between gap-3 max-[1150px]:flex-col" v-if="products.data.length > 0 || products_loading">
                <div class="w-28/38 center flex-col gap-3 max-[1150px]:w-full">
                    <template v-if="!products_loading">
                        <CartProduct :request="`cart/${cart.id}`" v-for="cart in products.data" :key="cart.id" :product="cart" @delete_cart="delete_cart"
                        :is_available="!!available_carts.find(item => item.id == cart.id)" />
                    </template>
                    <template v-else>
                        <ProductLikeBoxLoading />
                        <ProductLikeBoxLoading />
                        <ProductLikeBoxLoading />
                    </template>
                </div>
                <div class="w-9/38 p-[1.5rem] pb-[1.3rem] rounded-lg border border-gray-200/70 max-[1150px]:w-full sticky top-22 max-[1150px]:relative max-[1150px]:top-0">
                    <div
                        class="w-full flex items-center justify-start gap-2 text-title text-[17px] font-heavy pb-[1rem] border-b border-gray-200/70">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="none"
                            class="h-5 w-5 text-title transform-[translateY(-1.5px)]">
                            <path fill="currentColor"
                                d="M18.333 5v2.017c0 1.316-.833 2.15-2.15 2.15h-2.85V3.342c0-.925.759-1.675 1.684-1.675a3.35 3.35 0 0 1 2.341.975c.6.608.975 1.441.975 2.358Z">
                            </path>
                            <path fill="currentColor"
                                d="M1.667 5.833V17.5A.83.83 0 0 0 3 18.167L4.425 17.1a.84.84 0 0 1 1.1.083l1.383 1.392a.84.84 0 0 0 1.184 0l1.4-1.4a.826.826 0 0 1 1.083-.075L12 18.167a.835.835 0 0 0 1.333-.667V3.333c0-.916.75-1.666 1.667-1.666H5C2.5 1.667 1.667 3.158 1.667 5v.833Z"
                                opacity="0.4"></path>
                            <path fill="currentColor"
                                d="M10 8.125H5a.63.63 0 0 1-.625-.625A.63.63 0 0 1 5 6.875h5a.63.63 0 0 1 .625.625.63.63 0 0 1-.625.625Zm-.625 3.333h-3.75A.63.63 0 0 1 5 10.833a.63.63 0 0 1 .625-.625h3.75a.63.63 0 0 1 .625.625.63.63 0 0 1-.625.625Z">
                            </path>
                        </svg>
                        اطلاعات پرداخت
                    </div>
                    <div class="w-full center flex-col py-[0.8rem] border-b border-gray-200/70">
                        <div class="w-full flex items-center justify-between">
                            <p class="text-[#555775] font-bold text-[17px]">جمع کل</p>
                            <span class="text-[#6a6c87] text-[19px] font-bold">{{ total_price.toLocaleString() }}</span>
                        </div>
                        <div class="w-full flex items-center justify-between">
                            <p class="text-[#555775] font-bold text-[17px]">تخفیف</p>
                            <span class="text-theme text-[19px] font-bold">{{ total_discount.toLocaleString() }}
                                -</span>
                        </div>
                    </div>
                    <div class="w-full center flex-col gap-3 pt-[0.8rem]">
                        <div class="w-full flex items-center justify-between">
                            <p class="text-[#555775] font-bold text-[17px]">قابل پرداخت</p>
                            <span class="text-title text-[23px] font-heavy center gap-1">
                                {{ total_payment.toLocaleString() }}
                                <svg xmlns="http://www.w3.org/2000/svg" data-name="Layer 2" viewBox="0 0 51.29 27.19"
                                    width="51" height="27" class="size-[18px] fill-gray-400">
                                    <path
                                        d="M36.48 22.85c1.78-.83 2.93-1.81 3.45-2.94h-1.65c-2.53 0-4.69-.66-6.47-1.97-.59.68-1.23 1.2-1.93 1.55s-1.54.53-2.5.53c-1.03 0-1.87-.18-2.51-.53-.65-.35-1.14-.96-1.5-1.83-.35-.87-.56-2.08-.63-3.62-.02-.28-.04-.6-.04-.97s-.01-.72-.04-1.07c-.14-3.42-.28-6.26-.42-8.51l-5.8 1.37c.73 1.64 1.34 3.34 1.83 5.08.49 1.75.74 3.58.74 5.5 0 1.6-.37 3.12-1.11 4.57-.74 1.46-1.85 2.64-3.32 3.57-1.48.93-3.27 1.39-5.38 1.39s-3.82-.45-5.21-1.34C2.61 22.74 1.6 21.6.96 20.22c-.63-1.38-.95-2.84-.95-4.36 0-1.2.13-2.28.4-3.25.27-.97.63-1.93 1.07-2.87l2.39 1.34c-.38.92-.65 1.71-.83 2.39-.18.68-.26 1.48-.26 2.39 0 1.76.49 3.19 1.48 4.29s2.63 1.65 4.92 1.65c1.55 0 2.87-.32 3.96-.95 1.09-.63 1.9-1.44 2.43-2.43.53-.98.79-1.98.79-2.99 0-2.65-.82-5.82-2.46-9.5l1.69-3.52L22.38.79c.16-.05.39-.07.67-.07.54 0 .98.19 1.32.56s.53.88.58 1.51c.14 2.04.27 5.02.39 8.94.02.38.04.75.04 1.13s.01.71.04 1.02c.05 1.03.22 1.78.53 2.25s.81.7 1.51.7c.84 0 1.52-.18 2.04-.53.52-.35.97-1 1.37-1.93.75-1.71 1.33-2.96 1.74-3.75.41-.79.94-1.46 1.58-2.04.64-.57 1.44-.86 2.37-.86 1.83 0 3.27.94 4.31 2.83s1.69 4.06 1.95 6.53c1.57-.02 2.77-.13 3.61-.33.83-.2 1.41-.49 1.72-.88.32-.39.47-.89.47-1.5 0-.75-.16-1.67-.49-2.76-.33-1.09-.69-2.1-1.09-3.04l2.43-1.23c1.22 3.1 1.83 5.44 1.83 7.04 0 1.83-.67 3.18-2 4.04-1.34.87-3.53 1.34-6.58 1.41-.49 2.21-1.8 3.93-3.92 5.19-2.12 1.25-4.68 1.98-7.69 2.16l-1.2-2.88c2.6-.14 4.8-.63 6.58-1.46ZM10.38 5.66l.11 3.31-3.2.28-.46-3.31 3.55-.28Zm25.1 10.83c.88.28 1.81.42 2.8.42h1.93c-.16-1.67-.55-3.08-1.16-4.26-.61-1.17-1.38-1.76-2.32-1.76-.75 0-1.42.45-2.02 1.34-.6.89-1.11 1.92-1.53 3.1.66.49 1.42.88 2.3 1.16ZM43.64.21C45.06.07 46.43 0 47.74 0c.96 0 1.67.02 2.11.07l-.21 2.81c-.42-.05-1.08-.07-1.97-.07-1.2 0-2.44.07-3.73.21s-2.44.32-3.45.53L39.86.81c1.1-.26 2.36-.46 3.78-.6Z"
                                        data-name="Layer 1"></path>
                                </svg>
                            </span>
                        </div>
                        <div class="btn-theme center transition-custom w-full h-[45px] rounded-lg text-[15px] font-bold"
                            :class="{
                                'pointer-events-none bg-theme': isLoading
                            }" @click="payment">
                            <Loading v-if="isLoading" theme="white" />
                            <template v-else>
                                پرداخت سفارش
                            </template>
                        </div>
                    </div>
                </div>
            </div>
            <div class="w-full py-15 center flex-col gap-2 font-bold text-gray-600" v-else>
                <img lazy="true" src="~/assets/image/empty-cart.svg" alt="">
                موردی یافت نشده
            </div>
        </div>
    </div>
</template>