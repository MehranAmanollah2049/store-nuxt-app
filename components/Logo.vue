<script setup>

defineProps({
    is_large: {
        type: Boolean,
        default: false
    }
})

</script>

<template>
    <nuxt-link to="/" class="h-full">
        <NuxtImg lazy="true" class="w-[80px] h-full object-contain" :class="{
            'w-[130px]': is_large,
            'w-[80px]': !is_large
        }" src="/logo.png" alt="" />
    </nuxt-link>
</template>