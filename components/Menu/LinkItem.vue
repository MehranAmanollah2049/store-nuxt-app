<script setup>

defineProps({
    title: String,
    link: [null,String],
})

</script>

<template>
    <nuxt-link v-if="link != null" :to="link"  class="w-auto h-full center gap-2 text-title text-[14px] font-medium cursor-pointer">
        <slot />
        {{ title }}
    </nuxt-link>
    <div v-else :to="link"  class="w-auto h-full center gap-2 text-title text-[14px] font-medium cursor-pointer">
        <slot />
        {{ title }}
    </div>
</template>