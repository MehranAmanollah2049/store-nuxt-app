<script setup>
import { toast } from 'vue-toast-next'
import OtpInput from '~/components/Inputs/OtpInput.vue';
import { useAuth } from '~/stores/auth/useAuth';

definePageMeta({
  middleware: [
    'auth-verify-access',
  ],
});

const { $HttpRequest } = useNuxtApp()
const authStore = useAuth();
const { start, finish } = useLoadingIndicator()

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

        $HttpRequest('/auth/verify', {
            method: 'POST',
            body: {
                phone: authStore.phone_number,
                otp
            }
        })
            .then(res => {
                isLoading.value = false;
                if (res) {
                    if ('token' in res) {
                        authStore.login(res.token, res.user);
                    }
                    else {

                        authStore.set_register_access();
                        toast.success('شماره موبایل شما با موفقیت تایید شد');
                        return navigateTo('/auth/register');
                    }
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

        $HttpRequest('/auth/resend', {
            method: 'POST',
            body: {
                phone: authStore.phone_number
            }
        })
            .then(res => {
                resend_loading.value = false;
                finish()
                if (res) {
                    toast.success(`کد مجددا برای ${authStore.phone_number} ارسال گردید`)
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

onMounted(() => setTmer())

</script>


<template>
    <form action="" @submit.prevent="submitHandler" class="w-full">
        <div class="w-full center pb-3">
            <nuxt-link to="/auth" class="h-[28px] center gap-1 text-theme bg-theme-100 rounded-full text-[14px] px-3">
                {{ authStore.phone_number }}
                <svg xmlns="http://www.w3.org/2000/svg" class="size-[11px] fill-theme transform-[translateY(-0.8px)]"
                    viewBox="0 0 24 24">
                    <path
                        d="M22.987,5.451c-.028-.177-.312-1.767-1.464-2.928-1.157-1.132-2.753-1.412-2.931-1.44-.237-.039-.479,.011-.682,.137-.118,.073-2.954,1.849-8.712,7.566C3.135,14.807,1.545,17.213,1.48,17.312c-.091,.14-.146,.301-.159,.467l-.319,4.071c-.022,.292,.083,.578,.29,.785,.188,.188,.443,.293,.708,.293,.025,0,.051,0,.077-.003l4.101-.316c.165-.013,.324-.066,.463-.155,.1-.064,2.523-1.643,8.585-7.662,5.759-5.718,7.548-8.535,7.622-8.652,.128-.205,.178-.45,.14-.689Zm-9.17,7.922c-4.93,4.895-7.394,6.78-8.064,7.263l-2.665,.206,.206-2.632c.492-.672,2.393-3.119,7.312-8.004,1.523-1.512,2.836-2.741,3.942-3.729,.01,.002,.02,.004,.031,.006,.012,.002,1.237,.214,2.021,.98,.772,.755,.989,1.93,.995,1.959,0,.004,.002,.007,.002,.011-.999,1.103-2.245,2.416-3.78,3.94Zm5.309-5.684c-.239-.534-.597-1.138-1.127-1.656-.524-.513-1.134-.861-1.674-1.093,1.139-.95,1.908-1.516,2.309-1.797,.419,.124,1.049,.377,1.481,.8,.453,.456,.695,1.081,.81,1.469-.285,.4-.851,1.159-1.798,2.278Z">
                    </path>
                </svg>
            </nuxt-link>
        </div>
        <div class="w-full text-gray-400 text-[14px]">
            لطفا کد یکبار مصرف را وارد کنید
        </div>
        <div class="w-full py-2 center gap-2 flex-row-reverse">
            <OtpInput v-model="code" />
        </div>
        <div class="w-full center gap-2 mt-3">
            <div class="w-4/10 h-[50px] bg-gray-300 center text-gray-700 rounded-sm" v-if="seconds > 0">{{ formatTimer
            }}</div>
            <div :class="{
                'pointer-events-none bg-theme': resend_loading
            }" @click="resendHandler"
                class="w-4/10 h-[50px] bg-title border border-transparent center text-white rounded-md cursor-pointer transition-custom hover:bg-white hover:text-title hover:border-title"
                v-else>
                <Loading theme="white" v-if="resend_loading" />
                <template v-else>ارسال مجدد</template>
            </div>
            <button type="submit" class="btn-theme center transition-custom group w-6/10 h-[50px] text-[15.5px]" :class="{
                'pointer-events-none bg-theme': isLoading
            }">
                <Loading theme="white" v-if="isLoading" />
                <template v-else>تایید کد یکبار مصرف</template>
            </button>
        </div>
    </form>
</template>