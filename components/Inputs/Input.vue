<script setup>

let props = defineProps({
    placeholder: String,
    type: {
        type: String,
        default: 'text'
    },
    onlyNumber: {
        type: Boolean,
        default: false
    },
})

const model = defineModel()

let handleInput = (e) => {

    let val = e.target.value;

    if (props.onlyNumber) {
        model.value = e.target.value = val.replace(/[^0-9]/g, "")
    }
}

</script>

<template>
    <input :type="type" @input="handleInput" v-model="model"
        class="w-full h-[50px] outline-none text-title text-[15px] border rounded-sm border-gray-200 px-3 transition-custom focus:border-theme"
        :placeholder="placeholder">
</template>