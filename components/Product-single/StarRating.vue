<script setup>
import toast from 'vue-toast-next'
import { useUser } from '~/stores/auth/useUser'

defineProps({
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

const selectRate = (e) => {

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
                rate: e
            }
        })
            .then(res => {
                isLoading.value = false;
                finish()

                if (res) {
                    model.value = res
                    toast.success("امتیاز شما با موفقیت ثبت گردید")
                }
            })
            .catch(err => {
                isLoading.value = false;
                finish()
            })
    }
}

</script>

<template>
    <div class="w-full flex items-center justify-between my-7 p-5 bg-gray-100/60 rounded-xl">
        <p class="font-medium text-title text-[16px]">امتیاز خود را ثبت کنید: </p>
        <template v-if="!loading">
            <div class="center translate-y-[3px]" :style="{ direction: 'ltr' }">
                <NuxtRating :read-only="false" border-color="#f54900" active-color="#f54900" inactive-color="#fff"
                    :rating-step="0.5" :rounded-corners="true" :border-width="6" :rating-size="12" :rating-spacing="3"
                    :rating-value="model.rate" @rating-selected="selectRate"/>
            </div>
        </template>
        <template v-else>
            <div class="w-[90px] h-[14px] rounded-full bg-gray-200 animation-pluse"></div>
        </template>
    </div>
</template>