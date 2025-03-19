<script setup>
import { toast } from 'vue-toast-next'
import { useAuth } from '~/stores/auth/useAuth';

const { $HttpRequest } = useNuxtApp()
const authStore = useAuth();

let isLoading = ref(false)
let phone = ref(authStore.phone_number || '')

const submitHandler = () => {

    if (phone.value == '' || phone.value.length != 11) {
        toast.error("لطفا یک شماره موبایل معتبر وارد کنید")
        return
    }

    if (!isLoading.value) {
        isLoading.value = true;

        $HttpRequest('/auth/login', {
            method: 'POST',
            body: {
                phone: phone.value
            }
        })
            .then(res => {
                isLoading.value = false;
                if (res) {
                    // store data and access
                    authStore.phone_number = phone.value;
                    authStore.set_verify_access();

                    // response
                    toast.success(`کد تایید برای شماره ${phone.value} ارسال گردید`)
                    return navigateTo('/auth/verify');
                }
            })
            .catch(err => {
                isLoading.value = false
            })
    }
}

</script>

<template>
    <form action="" @submit.prevent="submitHandler" class="w-full">
        <div class="w-full text-gray-400 text-[14px]">
            سلام ! <br>
            لطفا شماره موبایل خود را وارد کنید
        </div>
        <div class="w-full py-2">
            <Input placeholder="شماره موبایل" v-model="phone" :onlyNumber="true" />
        </div>
        <button type="submit" class="btn-theme center transition-custom group w-full h-[50px] text-[15.5px] mt-3"
            :class="{
                'pointer-events-none bg-theme': isLoading
            }">
            <Loading theme="white" v-if="isLoading" />
            <template v-else>ارسال کد یکبار مصرف</template>
        </button>
    </form>
</template>