<script setup>

defineProps({
    score: String,
    title: String
})

</script>

<template>
    <div class="w-1/3 center flex-col gap-1 rounded-md border border-gray-200 transition-custom px-1 py-3 text-gray-400 font-bold cursor-pointer text-[14px]"
        :class="{
            'border-theme shadow-theme-150 text-theme': score == title
        }">
        <slot name="icon" :title="title" :score="score" />
        {{ title }}
    </div>
</template>