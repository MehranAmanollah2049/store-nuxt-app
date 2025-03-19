<script setup>

let props = defineProps({
    product_id: Number
})

const likes = defineModel()

const [isLikeLoading, handleLike, has_likes , load_likes] = useLike(props.product_id, (obj) => false)

load_likes(likes.value)

</script>

<template>
    <div class="center cursor-pointer" @click="handleLike">
        <svg class="size-[23px]" v-if="!isLikeLoading" :class="{
            'stroke-title': !has_likes,
            'fill-theme': has_likes,
        }" fill="none" width="13" height="11" viewBox="0 0 13 11" xmlns="http://www.w3.org/2000/svg">
            <path
                d="M3.95035 1.229C4.81955 1.229 5.61243 1.66166 6.21284 2.15457C6.81326 1.66166 7.60614 1.229 8.47534 1.229C10.3497 1.229 11.8691 2.62275 11.8691 4.34192C11.8691 7.80824 7.92382 9.82702 6.62321 10.3984C6.36123 10.5134 6.06445 10.5134 5.80248 10.3984C4.50187 9.827 0.556602 7.80816 0.556602 4.34184C0.556602 2.62267 2.07603 1.229 3.95035 1.229Z"
                stroke-width="0.761705"></path>
        </svg>
        <Loading v-else />
    </div>
</template>