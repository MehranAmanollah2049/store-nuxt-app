<script setup>
import toast from 'vue-toast-next';
import { useUser } from '~/stores/auth/useUser';

const userStore = useUser();

const phone = ref(userStore.user?.phone)

watch(() => userStore.user, () => {
    phone.value = userStore.user?.phone;
})

const { $HttpRequest } = useNuxtApp()
const { start, finish } = useLoadingIndicator()
const isLoading = ref(false)
const isActive = ref(false)

const submitHandler = () => {

    if (phone.value == '' || phone.value.length != 11) {
        return toast.error("لطفا یک شماره موبایل معتبر وارد کنید")
    }

    if (userStore.user.phone == phone.value) {
        return toast.error("اطلاعات جدیدی برای ویرایش یافت نشد")
    }

    if (!isLoading.value) {
        isLoading.value = true;
        start()

        $HttpRequest(`/panel/profile/verify-phone`, {
            method: 'POST',
            body: {
                phone: phone.value,
            }
        })
            .then(res => {
                console.log(res)
                isLoading.value = false
                finish()

                if (res) {
                    toast.success(`کد یکبار مصرف برای ${phone.value} ارسال گردید`)
                    isActive.value = true
                }
            })
            .catch(err => {
                isLoading.value = false
                finish()
            })
    }
}



</script>

<template>
    <div class="w-full pt-8 bg-white rounded-xl py-6 mt-5 px-8 max-[500px]:px-5 max-[500px]:py-5">
        <div class="w-full flex items-center justify-between mb-8">
            <p
                class="font-heavy text-[20px] max-[500px]:text-[18px] text-theme pr-5 center relative after:size-2 after:rounded-full after:bg-theme after:absolute after:content-[''] after:transform-[translateY(-0.5px)] after:right-0">
                ویرایش شماره موبایل</p>

        </div>
        <form class="w-full center flex-col gap-3" @submit.prevent="submitHandler">
            <div class="w-full center gap-2">
                <Input placeholder="شماره موبایل" v-model="phone" :onlyNumber="true" />
            </div>
            <div class="w-full flex items-center justify-end mt-2">
                <button type="submit" class="btn-theme center transition-custom h-[44px] text-[15px] px-7  max-[450px]:w-full" :class="{
                    'pointer-events-none bg-theme': isLoading
                }">
                    <Loading v-if="isLoading" theme="white" />
                    <template v-else>
                        ویرایش اطلاعات
                    </template>
                </button>
            </div>
        </form>
    </div>
    <VerifyPhoneBox v-model="isActive" v-model:phone="phone" />
</template>