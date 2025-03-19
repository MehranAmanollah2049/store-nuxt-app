<script setup>

defineProps({
    title: String,
    link: String,
    is_active: {
        type: Boolean,
        default: false
    }
})

</script>

<template>
    <nuxt-link :to="link" class="w-full py-3 px-4 flex items-center justify-between rounded-xl transition-custom"
        :class="{
            'bg-theme-100': is_active
        }">
        <div class="center gap-2">
            <slot :is_active="is_active" />
            <span class="text-[15.5px] font-medium transition-custom" :class="{
                'text-theme': is_active,
                'text-title': !is_active,
            }">{{ title }}</span>
        </div>
        <svg xmlns="http://www.w3.org/2000/svg" id="Outline" viewBox="0 0 24 24" width="512" height="512"
            class="size-[16px] transition-custom" :class="{
                'fill-theme': is_active,
                'fill-title': !is_active,
            }">
            <path
                d="M19,11H9l3.29-3.29a1,1,0,0,0,0-1.42,1,1,0,0,0-1.41,0l-4.29,4.3A2,2,0,0,0,6,12H6a2,2,0,0,0,.59,1.4l4.29,4.3a1,1,0,1,0,1.41-1.42L9,13H19a1,1,0,0,0,0-2Z" />
        </svg>
    </nuxt-link>
</template>