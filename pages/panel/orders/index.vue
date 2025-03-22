<script setup>

const { $HttpRequest } = useNuxtApp()

let loading = ref(true)
let items = ref([]);

const get_data = async () => {
    await $HttpRequest('/panel/orders')
        .then(res => {
            loading.value = false;

            if (res) {
                items.value = res.data
            }
        })
        .catch(err => {
            console.log(err)
            loading.value = false;
        })
}

onMounted(async () => {
    await get_data()
})

</script>

<template>
    <div class="w-full pt-8 bg-white rounded-xl py-6 px-8 max-[500px]:px-5 max-[500px]:py-5">
        <div class="w-full flex items-center justify-start">
            <p
                class="font-heavy text-[25px] max-[500px]:text-[18px] text-theme pr-5 center relative after:size-2 after:rounded-full after:bg-theme after:absolute after:content-[''] after:transform-[translateY(-0.5px)] after:right-0">
                سفارشات</p>
        </div>
        <div class="w-full center flex-col gap-2 mt-5">
            <template v-if="loading">
                <OrderCardLoading />
                <OrderCardLoading />
                <OrderCardLoading />
            </template>
            <template v-else-if="items.length > 0">
                <OrderCard v-for="order in items" :key="order.id" :order="order" />
            </template>
            <template v-else>
                <div class="w-full center flex-col gap-3 font-bold text-gray-600 py-3">
                    <NuxtImg lazy="true" src="/order-empty.svg" alt="" />
                    <span>موردی یافت نشد</span>
                </div>
            </template>
        </div>
    </div>
</template>