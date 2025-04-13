<script setup>
import toast from 'vue-toast-next'
import autoAnimate from "@formkit/auto-animate"

let isActive = ref(false)
let search = ref('')
let isLoading = ref(false)
let total = ref(0)
let products = ref([])

const { $HttpRequest } = useNuxtApp()

let typingTimeout = null

let send_request = () => {
    clearTimeout(typingTimeout)

    typingTimeout = setTimeout(() => {
        if (search.value != '') {
            isLoading.value = true

            $HttpRequest(`/search?search=${search.value}`)
                .then(res => {
                    isLoading.value = false

                    if (res) {
                        total.value = res.total
                        products.value = res.data
                    }
                })
                .catch(err => {
                    isLoading.value = false
                })
        } else {
            products.value = []
            total.value = 0
        }
    }, 700) // 3 seconds delay
}

const remove_search = () => {
    isActive.value = false
    search.value = ''
    total.value = 0
    products.value = []
}

const dropdown = ref()

onMounted(() => {
    autoAnimate(dropdown.value)
})

</script>

<template>
    <div class="w-[calc(100%-83px)] h-[40px] relative z-100 peer group" :class="{ 'active': isActive }">
        <div ref="dropdown"
            class="w-full max-[800px]:group-[.active]:w-[calc(100%+80px)] max-[800px]:group-[.active]:-right-[78px] absolute right-0 bg-white rounded-lg min-h-full overflow-x-hidden overflow-y-auto max-h-[calc(100vh-80px)] transition-custom group-[.active]:px-3">
            <div @click="isActive = true"
                class="w-full h-[40px] relative rounded-md transition-custom border-b border-transparent px-3 pr-9 center bg-gray-200/50 group-[.active]:rounded-none group-[.active]:h-[51px] group-[.active]:bg-white group-[.active]:border-gray-200">
                <svg class="size-4 absolute right-[13px] transform-[translateY(-0.3px)] group-[.active]:transform-[translateY(-0.5px)]"
                    viewBox="0 0 16 17" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <circle cx="7.82495" cy="7.82492" r="6.74142" stroke="gray" stroke-width="1.5"
                        stroke-linecap="round" stroke-linejoin="round"></circle>
                    <path d="M12.5137 12.8638L15.1568 15.4999" stroke="gray" stroke-width="1.5" stroke-linecap="round"
                        stroke-linejoin="round"></path>
                </svg>
                <input type="text" class="w-full h-full outline-none text-title text-[14px]"
                    placeholder="دنبال چی میگردی...؟" v-model="search" @input="send_request">
            </div>
            <div class="w-full py-4 px-3" v-if="isActive">
                <div class="w-full flex items-center justify-between">
                    <p class="text-[14px] text-gray-500">{{ search.length != 0 ? total : 0 }} کالا</p>
                    <nuxt-link :to="{ path: '/products', query: { search } }" @click="isActive = false"
                        class="text-theme text-[14px] center" v-if="search.length > 0 && total > 4">
                        مشاهده همه
                        <svg class="size-4 fill-theme transform-[translateY(-1px)]">
                            <use xlink:href="#chevronLeft">
                                <symbol id="chevronLeft" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                                    <path
                                        d="M11.414 12l4.293 4.293-1.414 1.414-5-5a1 1 0 010-1.414l5-5 1.414 1.414L11.414 12z">
                                    </path>
                                </symbol>
                            </use>
                        </svg>
                    </nuxt-link>
                </div>
                <div class="w-full pt-5 center flex-col gap-5">
                    <div class="w-full flex items-center justify-start gap-3 text-[15px] text-title font-medium"
                        v-if="isLoading">
                        <Loading />
                        در حال جستجو...
                    </div>
                    <p class="w-full text-[15px] text-title font-medium" v-else-if="search.length <= 0">شروع به جست
                        و جو کنید...</p>
                    <p class="w-full text-[15px] text-title font-medium"
                        v-else-if="search.length != 0 && products.length == 0">موردی یافت نشد</p>
                    <SearchResult v-else v-for="product in products" @removeSearch="remove_search" :key="product.id"
                        :search="search" :product="product" />
                </div>
            </div>
        </div>
    </div>
    <div class="fixed inset-0 z-99 bg-black opacity-0 invisible transition-custom peer-[.active]:visible peer-[.active]:opacity-40"
        @click="isActive = false">
    </div>
</template>