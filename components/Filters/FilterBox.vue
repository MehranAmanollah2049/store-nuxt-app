<script setup>
import { ref, onMounted, onUnmounted, watch } from 'vue';

let props = defineProps({
    title: String,
    default: {
        type: Boolean,
        default: true
    }
});

const is_open = ref(props.default);
const content = ref(null);
const Height = ref(0);
let observer = null;

const toggle_drp = () => {
    is_open.value = !is_open.value;
    updateHeight();
};

const updateHeight = () => {
    if (is_open.value && content.value) {
        Height.value = content.value.scrollHeight;
    } else {
        Height.value = 0;
    }
};

onMounted(() => {
    updateHeight();
    
    // ایجاد یک observer برای بررسی تغییر ارتفاع محتوا
    if (content.value) {
        observer = new ResizeObserver(updateHeight);
        observer.observe(content.value);
    }
});

onUnmounted(() => {
    if (observer && content.value) {
        observer.unobserve(content.value);
    }
});
</script>

<template>
    <div class="w-full relative border-b border-gray-200/70">
        <div class="w-full flex items-center justify-between py-4 px-2 cursor-pointer" @click="toggle_drp">
            <div class="flex items-center justify-start gap-2">
                <p class="text-[16px] text-title font-medium select-none">{{ title }}</p>
            </div>
            <svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 20 20"
                class="text-gray-400 size-4 transform-[translateY(0.5px)]" height="1em" width="1em"
                xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd"
                    d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                    clip-rule="evenodd"></path>
            </svg>
        </div>
        <div class="w-full overflow-hidden transition-custom" :style="{ height: Height + 'px' }">
            <div class="w-full flex items-start p-2 pt-0 pb-4 justify-center flex-col gap-3" ref="content">
                <slot />
            </div>
        </div>
    </div>
</template>
