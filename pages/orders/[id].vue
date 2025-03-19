<script setup>

const { $HttpRequest } = useNuxtApp()
const route = useRoute()

const order = ref({
    code: '-',
    status: '-'
})
const loading = ref(true)

onMounted(() => {
    $HttpRequest(`/order-status/${route.params.id}`)
        .then(res => {
            loading.value = false

            if (res) {
                order.value = res
            }
        })
        .catch(err => {
            navigateTo('/')
        })
})

</script>

<template>
    <div class="w-full py-45 px-5 center flex-col gap-4  max-[500px]:py-38">
        <template v-if="!loading">
            <div class="size-[110px] rounded-full center max-[500px]:size-[90px]" :class="{
                'bg-[#3bce9325]': order.status == 'پرداخت شده',
                'bg-theme-100': order.status != 'پرداخت شده',
            }">
                <svg class="size-[50px]  max-[500px]:size-[40px]" :class="{
                    'text-green': order.status == 'پرداخت شده',
                    'text-theme': order.status != 'پرداخت شده',
                }" width="56" height="40" viewBox="0 0 56 40" fill="none"
                    xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd"
                        d="M53.5978 8.60487C55.5504 6.65225 55.5504 3.48642 53.5978 1.5338C51.6451 -0.418819 48.4793 -0.418819 46.5267 1.5338L20.4493 27.6112L9.18202 16.3439C7.2294 14.3913 4.06357 14.3913 2.11095 16.3439C0.158329 18.2965 0.158329 21.4624 2.11095 23.415L16.9164 38.2204C18.869 40.173 22.0348 40.173 23.9874 38.2204C24.0332 38.1746 24.0779 38.1282 24.1215 38.0811L53.5978 8.60487Z"
                        fill="currentColor"></path>
                </svg>
            </div>
            <p class="text-title font-bold text-[20px] text-center  max-[500px]:text-[19px]">
                <template v-if="order.status == 'پرداخت شده'">
                    سفارش شما با کد تراکنش {{ order.code }} با <span class="font-bold text-green">موفقیت</span> ثبت گردید
                </template>
                <template v-else>
                    سفارش با <span class="font-bold text-theme">شکست</span> مواجه گردید
                </template>
            </p>
        </template>
        <template v-else>
            <div class="size-[110px] rounded-full bg-gray-200 animate-pulse  max-[500px]:size-[90px]"></div>

            <div class="w-[250px] h-[10px] rounded-full bg-gray-200 animate-pulse"></div>
            <div class="w-[180px] h-[10px] rounded-full bg-gray-200 animate-pulse"></div>
        </template>
    </div>
</template>