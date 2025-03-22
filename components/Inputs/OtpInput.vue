<script setup>
let model = defineModel();

const inputs = ref([]);

let inputsElem1 = ref(null);
let inputsElem2 = ref(null);
let inputsElem3 = ref(null);
let inputsElem4 = ref(null);
let inputsElem5 = ref(null);
let inputsElem6 = ref(null);

let inputHandler = (e, index) => {
    let value = e.target.value.replace(/[^0-9]/g, '').slice(0, 1); // فقط عدد و یک رقم
    model.value[index] = value;

    if (value.length === 1 && index < model.value.length - 1) {
        inputs.value[index + 1]?.focus();
    }
}

let onBackspace = (e, index) => {
    if (e.key === 'Backspace' && index > 0 && model.value[index] === '') {
        inputs.value[index - 1]?.focus();
    }
}

onMounted(() => {
    inputs.value = [
        inputsElem1.value,
        inputsElem2.value,
        inputsElem3.value,
        inputsElem4.value,
        inputsElem5.value,
        inputsElem6.value
    ];
});
</script>

<template>
    <input v-model="model[0]" @input="inputHandler($event, 0)" @keydown="onBackspace($event, 0)" type="text" inputmode="numeric"
        ref="inputsElem1"
        class="w-1/5 h-[50px] outline-none text-title text-[17px] border rounded-sm border-gray-200 px-3 transition-custom focus:border-theme text-center" />
    <input v-model="model[1]" @input="inputHandler($event, 1)" @keydown="onBackspace($event, 1)" type="text" inputmode="numeric"
        ref="inputsElem2"
        class="w-1/5 h-[50px] outline-none text-title text-[17px] border rounded-sm border-gray-200 px-3 transition-custom focus:border-theme text-center" />
    <input v-model="model[2]" @input="inputHandler($event, 2)" @keydown="onBackspace($event, 2)" type="text" inputmode="numeric"
        ref="inputsElem3"
        class="w-1/5 h-[50px] outline-none text-title text-[17px] border rounded-sm border-gray-200 px-3 transition-custom focus:border-theme text-center" />
    <input v-model="model[3]" @input="inputHandler($event, 3)" @keydown="onBackspace($event, 3)" type="text" inputmode="numeric"
        ref="inputsElem4"
        class="w-1/5 h-[50px] outline-none text-title text-[17px] border rounded-sm border-gray-200 px-3 transition-custom focus:border-theme text-center" />
    <input v-model="model[4]" @input="inputHandler($event, 4)" @keydown="onBackspace($event, 4)" type="text" inputmode="numeric"
        ref="inputsElem5"
        class="w-1/5 h-[50px] outline-none text-title text-[17px] border rounded-sm border-gray-200 px-3 transition-custom focus:border-theme text-center" />
</template>
