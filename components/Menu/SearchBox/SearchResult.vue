<script setup>

let props = defineProps({
    product: Object,
    search: String
})

let emits = defineEmits('removeSearch')

const highlightedTitle = computed(() => {
    const title = props.product.title;

    const regExp = new RegExp(`(${props.search})`, 'gi');
    return title.replace(regExp, `<mark class="bg-yellow-200 px-1">$1</mark>`);
});

</script>

<template>
    <nuxt-link :to="{ path: `/products/${product.id}` }" @click="emits('removeSearch')" class="w-full flex items-center justify-between">

        <div class="w-[calc(100%-50px)] flex items-center justify-start gap-3">
            <svg class="size-[17px] text-gray-400 transform-[translateY(-1px)]" viewBox="0 0 16 17" fill="none"
                xmlns="http://www.w3.org/2000/svg">
                <circle cx="7.82495" cy="7.82492" r="6.74142" stroke="gray" stroke-width="1.5" stroke-linecap="round"
                    stroke-linejoin="round"></circle>
                <path d="M12.5137 12.8638L15.1568 15.4999" stroke="gray" stroke-width="1.5" stroke-linecap="round"
                    stroke-linejoin="round"></path>
            </svg>
            <div class="w-[calc(100%-30px)] flex items-start justify-center flex-col gap-1">
                <p class="font-bold text-[16px] text-title w-full max-[800px]:text-[14px]" v-html="highlightedTitle">
                </p>
                <p class="text-gray-500 text-[14px] font-medium max-[800px]:text-[13px]">در دسته <span
                        class="text-theme font-medium">{{
                            product.category }}</span></p>
            </div>
        </div>

        <svg class="size-5 fill-gray-400">
            <use xlink:href="#searchPlaceSuggest">
                <symbol id="searchPlaceSuggest" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                    <path d="M17 8.414L6.707 18.707l-1.414-1.414L15.586 7H9V5h9a1 1 0 011 1v9h-2V8.414z"></path>
                </symbol>
            </use>
        </svg>
    </nuxt-link>
</template>