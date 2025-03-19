<script setup>
import BottomSheet from '@douxcode/vue-spring-bottom-sheet'
import '@douxcode/vue-spring-bottom-sheet/dist/style.css'

const bottomSheet = defineModel()

</script>

<template>
    <ClientOnly>
        <BottomSheet ref="bottomSheet" :expand-on-content-drag="true">
            <slot />
        </BottomSheet>
    </ClientOnly>
</template>