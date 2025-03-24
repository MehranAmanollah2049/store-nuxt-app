<script setup>
import toast from 'vue-toast-next'
import { useUser } from '~/stores/auth/useUser'

let props = defineProps({
    loading: {
        type: Boolean,
        default: false
    }
})

const model = defineModel()

const route = useRoute()
const { $HttpRequest } = useNuxtApp()
const { start, finish } = useLoadingIndicator()

const userStore = useUser()

const isLoading = ref(false)

const active_index = ref(-1)
const is_mouse_leave = ref(true)

const selectRate = (rate) => {

    if (!userStore.isLoggedIn()) {
        toast.error("ابتدا وارد حساب خود شوید")
        return;
    }

    if (!isLoading.value) {
        isLoading.value = true;
        start()

        $HttpRequest(`/rate/${route.params.id}`, {
            method: 'POST',
            body: {
                rate
            }
        })
            .then(res => {
                isLoading.value = false;
                finish()

                if (res) {
                    model.value = res
                    active_index.value = res.rate
                    toast.success("امتیاز شما با موفقیت ثبت گردید")
                }
            })
            .catch(err => {
                isLoading.value = false;
                finish()
            })
    }
}



const mouse_in = (index) => {
    active_index.value = index
    is_mouse_leave.value = false
}

const mouse_leave = () => {
    active_index.value = model.value.rate
    is_mouse_leave.value = true
}

watch(() => props.loading, () => {
    if (!props.loading) {
        active_index.value = model.value.rate
    }
})


</script>

<template>
    <div class="w-full flex items-center justify-between my-7 p-5 bg-gray-100/60 rounded-xl">
        <p class="font-medium text-title text-[16px]">امتیاز خود را ثبت کنید: </p>
        <template v-if="!loading">
            <div class="center gap-[3px]" :style="{ direction: 'ltr' }" @mouseleave="mouse_leave">
                <svg xmlns="http://www.w3.org/2000/svg" v-for="index in 5" :key="index"
                    class="size-[19px] transform-[translateY(-2px)] transition ease-in-out duration-100 fill-gray-400/50 cursor-pointer"
                    :class="{
                        'fill-orange-600': index <= Math.ceil(active_index),
                        'scale-115': index == active_index && !is_mouse_leave
                    }" @mouseover="mouse_in(index)" @click="selectRate(index)" viewBox="0 0 24 24" width="512"
                    height="512">
                    <path
                        d="M1.327,12.4,4.887,15,3.535,19.187A3.178,3.178,0,0,0,4.719,22.8a3.177,3.177,0,0,0,3.8-.019L12,20.219l3.482,2.559a3.227,3.227,0,0,0,4.983-3.591L19.113,15l3.56-2.6a3.227,3.227,0,0,0-1.9-5.832H16.4L15.073,2.432a3.227,3.227,0,0,0-6.146,0L7.6,6.568H3.231a3.227,3.227,0,0,0-1.9,5.832Z">
                    </path>
                </svg>
            </div>
        </template>
        <template v-else>
            <div class="w-[90px] h-[14px] rounded-full bg-gray-200 animation-pluse"></div>
        </template>
    </div>
</template>