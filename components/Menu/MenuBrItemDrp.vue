<script setup>

defineProps({
    keyItem: String,
    title: String,
    list: Array,
    loading: {
        type: Boolean,
        default: false
    }
})

const sheet = defineModel('sheet')

const is_open = ref(false)
const content = ref(null)
const Height = ref(0)

const toggle_drp = () => {
    is_open.value = !is_open.value;

    if (is_open.value) {
        Height.value = content.value.clientHeight;
    }
    else {
        Height.value = 0
    }
}

</script>

<template>
    <div class="w-full py-1">
        <div class="w-full flex items-center justify-between gap-1 cursor-pointer" @click="toggle_drp">
            <div class="flex items-center justify-start gap-1  text-[15px] font-medium transition-custom" :class="{
                'text-theme': is_open,
                'text-title': !is_open
            }">
                <slot />
                {{ title }}
            </div>
            <svg class="size-4 fill-title transform-[rotate(-90deg)]">
                <use xlink:href="#chevronLeft">
                    <symbol id="chevronLeft" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                        <path d="M11.414 12l4.293 4.293-1.414 1.414-5-5a1 1 0 010-1.414l5-5 1.414 1.414L11.414 12z">
                        </path>
                    </symbol>
                </use>
            </svg>
        </div>
        <div class="w-full overflow-hidden transition-custom" :style="{ height: Height + 'px' }">
            <div class="w-full flex items-start pt-2 justify-center flex-col gap-1" ref="content">
                <template v-if="loading">
                    <div class="w-full h-[40px] center">
                        <Loading />
                    </div>
                </template>
                <template v-else>
                    <nuxt-link @click="sheet.close()" v-for="item in list" :to="`/products?${keyItem}=${item.id}`"
                        class="w-full group/item font-medium text-gray-500 text-[15px] py-2 px-3 hover:bg-gray-100/80 hover:text-theme flex items-center justify-between transition-custom whitespace-nowrap gap-2">
                        {{ item.title }}
                        <svg class="size-4 fill-gray-400 transition-custom group-hover/item:fill-theme">
                            <use xlink:href="#chevronLeft">
                                <symbol id="chevronLeft" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                                    <path
                                        d="M11.414 12l4.293 4.293-1.414 1.414-5-5a1 1 0 010-1.414l5-5 1.414 1.414L11.414 12z">
                                    </path>
                                </symbol>
                            </use>
                        </svg>
                    </nuxt-link>
                </template>

            </div>
        </div>
    </div>
</template>