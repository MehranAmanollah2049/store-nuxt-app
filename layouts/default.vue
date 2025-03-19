<script setup>

const { $HttpRequest } = useNuxtApp()

const menu_data = ref({
    categorys: [],
    brands: []
})

const menu_data_loading = ref(true)

const load_menu = async () => {
    await $HttpRequest('/menu-detail')
        .then(res => {
            menu_data_loading.value = false
            menu_data.value = res
        })
}

load_menu()

provide("menu_data" ,  menu_data)
provide("menu_data_loading" , menu_data_loading)

</script>

<template>
    <Menu />
    <slot />
    <Footer />
    <MenuBar />
</template>