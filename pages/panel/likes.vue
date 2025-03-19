<script setup>

const { $HttpRequest } = useNuxtApp()

let loading = ref(true)
let items = ref([]);

const get_data = async () => {
    await $HttpRequest('/panel/likes')
        .then(res => {
            loading.value = false;

            if (res) {
                items.value = res.data
            }
        })
        .catch(err => {
            loading.value = false;
        })
}

const decrease_like_count = (obj) => {
    items.value = items.value.filter(item => item.id != obj.id)
}

onMounted(async () => {
    await get_data()
})

</script>

<template>
    <div class="w-full pt-8 bg-white rounded-xl py-6 px-8 max-[500px]:px-5 max-[500px]:py-5">
        <div class="w-full flex items-center justify-start">
            <p class="font-heavy text-[25px] max-[500px]:text-[18px] text-theme pr-5 center relative after:size-2 after:rounded-full after:bg-theme after:absolute after:content-[''] after:transform-[translateY(-0.5px)] after:right-0">علاقه مندی ها</p>
        </div>
        <div class="w-full center flex-col gap-2 mt-5">
            <template v-if="loading">
                <ProductLikeBoxLoading />
                <ProductLikeBoxLoading />
                <ProductLikeBoxLoading />
            </template>
            <template v-else-if="items.length > 0">
                <ProductLikeBox v-for="product in items" :key="product.id" :product="product"
                    @like_tracker="decrease_like_count" />
            </template>
            <template v-else>
                <div class="w-full center flex-col gap-3 font-bold text-gray-600 py-3">
                    <img src="~/assets/image/favorites-list-empty.svg" alt="">
                    <span>موردی یافت نشد</span>
                </div>
            </template>
        </div>
    </div>
</template>