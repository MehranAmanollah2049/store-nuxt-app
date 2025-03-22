<script setup>

defineProps({
    order: Object
})

</script>

<template>
    <div class="w-full rounded-lg border border-gray-200/70 bg-white p-6">
        <div class="w-full flex items-center justify-between max-[720px]:flex-col max-[720px]:gap-4">
            <div class="flex items-center justify-start gap-2">
                <div class="h-[28px] px-3 font-medium rounded-full text-[15px] center bg-[#ff990021] text-[#f90]">درگاه {{ order.driver }}</div>
                <div class="h-[28px] px-3 font-medium rounded-full text-[15px] center" :class="{
                    'bg-[#00c07318] text-[#00c073]': order.status == 'پرداخت شده',
                    'bg-[#ed19431a] text-[#ed1943]': order.status == 'پرداخت نشده',
                }">{{ order.status }}</div>
            </div>

            <nuxt-link :to="`/panel/orders/${order.id}`" class="text-title text-[14px] center">
                مشاهده جزییات
                <svg class="size-4 fill-title transform-[translateY(-1px)]">
                    <use xlink:href="#chevronLeft">
                        <symbol id="chevronLeft" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                            <path d="M11.414 12l4.293 4.293-1.414 1.414-5-5a1 1 0 010-1.414l5-5 1.414 1.414L11.414 12z">
                            </path>
                        </symbol>
                    </use>
                </svg>
            </nuxt-link>
        </div>
        <div class="w-full flex items-center justify-start gap-7 my-5 max-[720px]:flex-col max-[720px]:gap-3">
            <p class="text-title font-bold"># کد تراکنش: {{ order.code }}</p>
            <p class="text-gray-400 font-medium">تاریخ: {{ order.created_at }}</p>
            <p class="text-gray-400 font-medium">مبلغ: {{ order.total }} تومان </p>
        </div>
        <div class="w-full bg-gray-100/60 rounded-lg p-3 flex items-center justify-start flex-wrap gap-4 max-[720px]:gap-2">
            <nuxt-link :to="`/products/${product.product_id}?type=${product.productType_id}`" class="center relative" v-for="product in order.products" :key="product.id">
                <div
                    class="bg-[#4a6dff] text-white rounded-full min-w-[20px] h-[20px] center absolute top-0 -left-2 font-medium text-[14px] max-[720px]:-left-0">
                    {{ product.count }}</div>
                <img lazy="true" :src="useRuntimeConfig().public.BASEURL + product.image" alt=""
                    class="size-[120px] object-contain rounded-lg">
            </nuxt-link>
        </div>
    </div>
</template>