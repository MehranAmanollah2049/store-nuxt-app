<script setup>
import toast from 'vue-toast-next'
import { useUser } from '~/stores/auth/useUser'


const { $HttpRequest } = useNuxtApp()
const userStore = useUser()
const { start, finish } = useLoadingIndicator()

const isActive = defineModel()
const phone = defineModel('phone')

let isLoading = ref(false)
let code = ref(['', '', '', '', ''])

const submitHandler = () => {

    let otp = code.value.join('');

    if (otp == '') {
        toast.error("کد ارسال شده را وارد کنید");
        return;
    }

    if (!isLoading.value) {
        isLoading.value = true;

        $HttpRequest('/panel/profile/edit-phone', {
            method: 'POST',
            body: {
                phone: phone.value,
                otp
            }
        })
            .then(res => {
                isLoading.value = false;
                if (res) {
                    isActive.value = false
                    userStore.user.phone = phone.value
                    toast.success("شماره موبایل شما با موفقیت تایید شد")
                    code.value = ['', '', '', '', '']
                }
            })
            .catch(err => {
                isLoading.value = false
            })
    }

}

// resend
let resend_loading = ref(false)

let resendHandler = () => {
    if (!resend_loading.value) {
        resend_loading.value = true;
        
        start()

        $HttpRequest('/panel/profile/resend', {
            method: 'POST',
            body: {
                phone: phone.value
            }
        })
            .then(res => {
                resend_loading.value = false;
                finish()
                if (res) {
                    toast.success(`کد مجددا برای ${phone.value} ارسال گردید`)
                    seconds.value = 120
                    setTmer()
                }
            })
            .catch(err => {
                resend_loading.value = false
                finish()
            })
    }
}

// timer
let seconds = ref(120);

let setTmer = () => {
    let set = setInterval(() => {
        --seconds.value

        if (seconds.value <= 0) {
            clearInterval(set)
        }
    }, 1000);
}

let formatTimer = computed(() => {
    let mins = Math.floor(seconds.value / 60);
    let secs = Math.floor(seconds.value % 60);

    return `${mins < 10 ? '0' + mins : mins}:${secs < 10 ? '0' + secs : secs}`
})

watch(isActive , () => setTmer())
</script>

<template>
    <div class="fixed inset-0 bg-[#0000004f] z-200 center opacity-0 invisible transition-custom" :class="{
        'opacity-100 visible': isActive
    }">
        <div class="fixed inset-0 z-1" @click="isActive = false"></div>
        <div class="w-[400px] max-[600px]:w-full max-[600px]:h-screen max-[600px]:max-h-screen max-[600px]:rounded-none flex items-center justify-between flex-col py-2 px-6  relative bg-white rounded-lg z-2 overflow-y-auto max-h-[calc(100vh-50px)] scrollbar-hide">
            <div class="w-full h-full">
                <div class="w-full flex items-center justify-between py-3 border-b border-gray-200/70">
                    <p class="text-title font-medium text-[18px]">تایید شماره موبایل</p>
                    <svg fill="none" stroke-width="0" viewBox="0 0 24 24" @click="isActive = false"
                        class="size-5 text-gray-500 transform-[translateY(-1px)] cursor-pointer" height="20" width="20"
                        xmlns="http://www.w3.org/2000/svg">
                        <path
                            d="M6.2253 4.81108C5.83477 4.42056 5.20161 4.42056 4.81108 4.81108C4.42056 5.20161 4.42056 5.83477 4.81108 6.2253L10.5858 12L4.81114 17.7747C4.42062 18.1652 4.42062 18.7984 4.81114 19.1889C5.20167 19.5794 5.83483 19.5794 6.22535 19.1889L12 13.4142L17.7747 19.1889C18.1652 19.5794 18.7984 19.5794 19.1889 19.1889C19.5794 18.7984 19.5794 18.1652 19.1889 17.7747L13.4142 12L19.189 6.2253C19.5795 5.83477 19.5795 5.20161 19.189 4.81108C18.7985 4.42056 18.1653 4.42056 17.7748 4.81108L12 10.5858L6.2253 4.81108Z"
                            fill="currentColor"></path>
                    </svg>
                </div>
                <form @submit.prevent="submitHandler" class="w-full h-[calc(100%-100px)] center flex-col gap-5 py-5 pt-7  max-[600px]:px-0">
                    <div class="w-full text-gray-400 text-[14px]">
                        لطفا کد یکبار مصرف را وارد کنید
                    </div>
                    <div class="w-full center gap-2 flex-row-reverse">
                        <OtpInput v-model="code" />
                    </div>
                    <div class="w-full center gap-2 mt-3">
                        <div class="w-4/10 h-[50px] bg-gray-300 center text-gray-700 rounded-sm" v-if="seconds > 0">{{
                            formatTimer
                            }}</div>
                        <div :class="{
                            'pointer-events-none bg-theme': resend_loading
                        }" @click="resendHandler"
                            class="w-4/10 h-[50px] bg-title border border-transparent center text-white rounded-md cursor-pointer transition-custom hover:bg-white hover:text-title hover:border-title"
                            v-else>
                            <Loading theme="white" v-if="resend_loading" />
                            <template v-else>ارسال مجدد</template>
                        </div>
                        <button type="submit"
                            class="btn-theme center transition-custom group w-6/10 h-[50px] text-[15.5px]" :class="{
                                'pointer-events-none bg-theme': isLoading
                            }">
                            <Loading theme="white" v-if="isLoading" />
                            <template v-else>تایید کد یکبار مصرف</template>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>