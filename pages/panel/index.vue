<script setup>

const { $HttpRequest } = useNuxtApp()

let box_loadings = ref(true)
let box_data = ref([]);

const get_data = async () => {
    await $HttpRequest('/panel/data')
        .then(res => {
            box_loadings.value = false;

            if (res) {
                box_data.value = res.data
            }
        })
        .catch(err => {
            box_loadings.value = false;
        })
}

let likes_loading = ref(true)
let like_product = ref([]);

const get_like_product = async () => {
    await $HttpRequest('/panel/likes?limit=1')
        .then(res => {
            likes_loading.value = false;

            if (res) {
                like_product.value = res.data
            }
        })
        .catch(err => {
            likes_loading.value = false;
        })
}

const decrease_like_count = (obj) => {
    box_data.value[2] -= 1
}

let orders_loading = ref(true)
let orders = ref([]);

const get_last_order = async () => {
    await $HttpRequest('/panel/orders?limit=2')
        .then(res => {
            orders_loading.value = false;

            if (res) {
                orders.value = res.data
            }
        })
        .catch(err => {
            orders_loading.value = false;
        })
}

onMounted(async () => {
    await get_data()
    await get_like_product();
    await get_last_order()
})

</script>

<template>
    <div class="w-full py-6 px-8 bg-white rounded-xl max-[500px]:px-5 max-[500px]:py-5">
        <div class="w-full flex items-center justify-start gap-y-5 pt-3 flex-wrap">
            <DataBox :loading="box_loadings" title="سفارشات موفق" :count="box_data[0]" theme="success"></DataBox>
            <DataBox :loading="box_loadings" title="سفارشات ناموفق" :count="box_data[1]" theme="error"></DataBox>
            <DataBox :loading="box_loadings" title="علاقه مندی ها" :count="box_data[2]" theme="orange"></DataBox>
            <DataBox :loading="box_loadings" title="سبد خرید" :count="box_data[3]"></DataBox>
        </div>

        <div class="w-full center flex-col">
            <div class="w-full center h-[1px] bg-gray-200/70 my-10 mb-7">
                <span class="px-4 bg-white text-title text-[15px] font-medium">اخرین علاقه مندی ها </span>
            </div>
            <div class="w-full center flex-col gap-3">
                <template v-if="likes_loading">
                    <ProductLikeBoxLoading />
                </template>
                <template v-else-if="like_product.length > 0">
                    <ProductLikeBox v-for="product in like_product" :key="product.id" :product="product"
                        @like_tracker="decrease_like_count" />
                </template>
                <template v-else>
                    <div class="w-full center flex-col gap-3 font-bold text-gray-600 py-3">
                        <img lazy="true" src="/favorites-list-empty.svg" alt="" />
                        <span>موردی یافت نشد</span>
                    </div>
                </template>
            </div>
        </div>
    </div>
    <div class="w-full pt-8 bg-white rounded-xl mt-5 py-6 px-8 max-[500px]:px-5 max-[500px]:py-5">
        <div class="w-full flex items-center justify-start">
            <p
                class="font-heavy text-[25px] max-[500px]:text-[18px] text-theme pr-5 center relative after:size-2 after:rounded-full after:bg-theme after:absolute after:content-[''] after:transform-[translateY(-0.5px)] after:right-0">
                آخرین سفارشات</p>
        </div>
        <div class="w-full center flex-col gap-2 mt-5">
            <template v-if="orders_loading">
                <OrderCardLoading />
                <OrderCardLoading />
            </template>
            <template v-else-if="orders.length > 0">
                <OrderCard v-for="order in orders" :key="order.id" :order="order" />
            </template>
            <template v-else>
                <div class="w-full center flex-col gap-3 font-bold text-gray-600 py-3">
                    <img lazy="true" src="/order-empty.svg" alt="" />
                    <span>موردی یافت نشد</span>
                </div>
            </template>
        </div>
    </div>
</template>