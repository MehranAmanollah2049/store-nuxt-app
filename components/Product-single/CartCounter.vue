<script setup>

defineProps({
    count: Number,
    total: Number,
    loading: {
        type: Boolean,
        default: false
    }
})

let emits = defineEmits(['next', 'prev'])

</script>

<template>
    <div class="h-[40px] flex items-center justify-between gap-2 border border-gray-200 rounded-full px-1">
        <div class="size-[25px] bg-title rounded-full center cursor-pointer" @click="emits('next')" :class="{
            'opacity-40 pointer-events-none bg-theme': count >= total
        }">
            <svg xmlns="http://www.w3.org/2000/svg" class="size-[21px] fill-white" viewBox="0 0 24 24" width="512"
                height="512">
                <path
                    d="M17,11H13V7a1,1,0,0,0-1-1h0a1,1,0,0,0-1,1v4H7a1,1,0,0,0-1,1H6a1,1,0,0,0,1,1h4v4a1,1,0,0,0,1,1h0a1,1,0,0,0,1-1V13h4a1,1,0,0,0,1-1h0A1,1,0,0,0,17,11Z" />
            </svg>
        </div>
        <span class="min-w-[30px] center text-title font-bold text-[17px] px-1">
            <LoadingDots v-if="loading" />
            <template v-else>
                {{ count }}
            </template>
        </span>
        <div class="size-[25px] bg-title rounded-full center cursor-pointer"  @click="emits('prev')" v-if="count > 1">
            <svg xmlns="http://www.w3.org/2000/svg" class="size-[21px] fill-white" viewBox="0 0 24 24" width="512"
                height="512">
                <rect x="6" y="11" width="12" height="2" rx="1" />
            </svg>
        </div>
        <div class="rounded-full pl-1 center cursor-pointer"  @click="emits('prev')" v-else>
            <svg xmlns="http://www.w3.org/2000/svg" class="size-[18.5px] transform-[translateY(-0.5px)] fill-theme"
                viewBox="0 0 24 24" width="512" height="512">
                <path
                    d="M21,4H17.9A5.009,5.009,0,0,0,13,0H11A5.009,5.009,0,0,0,6.1,4H3A1,1,0,0,0,3,6H4V19a5.006,5.006,0,0,0,5,5h6a5.006,5.006,0,0,0,5-5V6h1a1,1,0,0,0,0-2ZM11,2h2a3.006,3.006,0,0,1,2.829,2H8.171A3.006,3.006,0,0,1,11,2Zm7,17a3,3,0,0,1-3,3H9a3,3,0,0,1-3-3V6H18Z" />
                <path d="M10,18a1,1,0,0,0,1-1V11a1,1,0,0,0-2,0v6A1,1,0,0,0,10,18Z" />
                <path d="M14,18a1,1,0,0,0,1-1V11a1,1,0,0,0-2,0v6A1,1,0,0,0,14,18Z" />
            </svg>
        </div>
    </div>
</template>