<script setup>
import toast from 'vue-toast-next';
import { useUser } from '~/stores/auth/useUser';

const userStore = useUser();

const name = ref(userStore.user?.name)
const lastname = ref(userStore.user?.lastname)

watch(() => userStore.user, () => {
    name.value = userStore.user?.name;
    lastname.value = userStore.user?.lastname;
})

const { $HttpRequest } = useNuxtApp()
const { start, finish } = useLoadingIndicator()
const isLoading = ref(false)

const submitHandler = () => {

    if (name.value == '' || lastname.value == '') {
        return toast.error("لطفا اطلاعات را به درستی وارد کنید")
    }

    if (userStore.user.name == name.value && userStore.user.lastname == lastname.value) {
        return toast.error("اطلاعات جدیدی برای ویرایش یافت نشد")
    }

    if (!isLoading.value) {
        isLoading.value = true;
        start()

        $HttpRequest(`/panel/profile/update`, {
            method: 'PUT',
            body: {
                name: name.value,
                lastname: lastname.value,
            }
        })
            .then(res => {
                isLoading.value = false
                finish()

                if (res) {
                    toast.success("اطلاعات ویرایش شدند")

                    userStore.user.name = name.value;
                    userStore.user.lastname = lastname.value;
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
    <div class="w-full pt-8 bg-white rounded-xl py-6 px-8 max-[500px]:px-5 max-[500px]:py-5">
        <div class="w-full flex items-center justify-between mb-8">
            <p
                class="font-heavy text-[20px] max-[500px]:text-[18px] text-theme pr-5 center relative after:size-2 after:rounded-full after:bg-theme after:absolute after:content-[''] after:transform-[translateY(-0.5px)] after:right-0">
                ویرایش اطلاعات</p>

        </div>
        <form class="w-full center flex-col gap-3" @submit.prevent="submitHandler">
            <div class="w-full center gap-2">
                <Input placeholder="نام" v-model="name" />
                <Input placeholder="نام خانوادگی" v-model="lastname" />
            </div>
            <div class="w-full flex items-center justify-end mt-2">
                <button type="submit" class="btn-theme center transition-custom h-[44px] text-[15px] px-7 max-[450px]:w-full" :class="{
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
</template>