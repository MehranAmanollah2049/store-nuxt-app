<script setup>
import { toast } from 'vue-toast-next'
import { useAuth } from '~/stores/auth/useAuth';

definePageMeta({
  middleware: [
    'auth-register-access',
  ],
});


const { $HttpRequest } = useNuxtApp()
const authStore = useAuth();

let isLoading = ref(false)
let name = ref('')
let lastname = ref('')

const submitHandler = () => {
    if (name.value == '' || lastname.value == '') {
        toast.error("لطفا اطلاعات خواسته شده را به درستی وارد کنید")
        return
    }


    if (!isLoading.value) {
        isLoading.value = true;

        $HttpRequest('/auth/register', {
            method: 'POST',
            body: {
                name: name.value,
                lastname: lastname.value,
                phone: authStore.phone_number,
            }
        })
            .then(res => {
                isLoading.value = false;

                if (res) {
                    authStore.login(res.token, res.user)
                }
            })
            .catch(err => {
                console.log(err)
                isLoading.value = false
            })
    }
}

</script>

<template>
    <form action="" @submit.prevent="submitHandler" class="w-full">
        <div class="w-full text-gray-400 text-[14px]">
            برای عضویت اطلاعات خود را تکمیل کنید
        </div>
        <div class="w-full py-2">
            <Input placeholder="نام" v-model="name" />
        </div>
        <div class="w-full py-2">
            <Input placeholder="نام خانوادگی" v-model="lastname" />
        </div>
        <button type="submit" class="btn-theme center transition-custom group w-full h-[50px] text-[15.5px] mt-3"
            :class="{
                'pointer-events-none bg-theme': isLoading
            }">
            <Loading theme="white" v-if="isLoading" />
            <template v-else>تکمیل عضویت</template>
        </button>
    </form>
</template>