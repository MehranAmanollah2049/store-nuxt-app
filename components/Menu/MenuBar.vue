<script setup>
import toast from 'vue-toast-next'
import { useUser } from '~/stores/auth/useUser'

const userStore = useUser()
const router = useRoute()

const menu_data = inject("menu_data");

const bottomSheet = ref(null)

const cart_redirect = () => {
    if (!userStore.isLoggedIn()) {
        return toast.error("ابتدا وارد حساب خود شوید")
    }

    return navigateTo('/cart')
}

</script>

<template>
    <div class="w-full fixed bottom-0 z-50 bg-white center border-t border-gray-200 min-[800px]:!hidden">
        <nuxt-link to="/" class="w-1/4 flex items-center justify-between group flex-col gap-[6px] py-3 pb-2"
            :class="{ 'active': router.path == '/' }">
            <svg xmlns="http://www.w3.org/2000/svg"
                class="size-[21px] fill-gray-500 transition-custom group-[.active]:fill-theme" viewBox="0 0 24 24"
                width="512" height="512">
                <path
                    d="M22,5.724V2c0-.552-.447-1-1-1s-1,.448-1,1v2.366L14.797,.855c-1.699-1.146-3.895-1.146-5.594,0L2.203,5.579c-1.379,.931-2.203,2.48-2.203,4.145v9.276c0,2.757,2.243,5,5,5h3c.553,0,1-.448,1-1V15c0-.551,.448-1,1-1h4c.552,0,1,.449,1,1v8c0,.552,.447,1,1,1h3c2.757,0,5-2.243,5-5V9.724c0-1.581-.744-3.058-2-4Zm0,13.276c0,1.654-1.346,3-3,3h-2v-7c0-1.654-1.346-3-3-3h-4c-1.654,0-3,1.346-3,3v7h-2c-1.654,0-3-1.346-3-3V9.724c0-.999,.494-1.929,1.322-2.487L10.322,2.513c1.02-.688,2.336-.688,3.355,0l7,4.724c.828,.558,1.322,1.488,1.322,2.487v9.276Z" />
            </svg>
            <span class="text-gray-500 font-medium text-[15px] transition-custom group-[.active]:text-theme">خانه</span>
        </nuxt-link>
        <div class="w-1/4 cursor-pointer flex items-center justify-between group flex-col gap-[6px] py-3 pb-2"
            @click="bottomSheet.open()">
            <svg xmlns="http://www.w3.org/2000/svg" class="size-[21px] fill-gray-500" viewBox="0 0 24 24" width="512"
                height="512">
                <path
                    d="M7,0H4A4,4,0,0,0,0,4V7a4,4,0,0,0,4,4H7a4,4,0,0,0,4-4V4A4,4,0,0,0,7,0ZM9,7A2,2,0,0,1,7,9H4A2,2,0,0,1,2,7V4A2,2,0,0,1,4,2H7A2,2,0,0,1,9,4Z" />
                <path
                    d="M7,13H4a4,4,0,0,0-4,4v3a4,4,0,0,0,4,4H7a4,4,0,0,0,4-4V17A4,4,0,0,0,7,13Zm2,7a2,2,0,0,1-2,2H4a2,2,0,0,1-2-2V17a2,2,0,0,1,2-2H7a2,2,0,0,1,2,2Z" />
                <path
                    d="M20,13H17a4,4,0,0,0-4,4v3a4,4,0,0,0,4,4h3a4,4,0,0,0,4-4V17A4,4,0,0,0,20,13Zm2,7a2,2,0,0,1-2,2H17a2,2,0,0,1-2-2V17a2,2,0,0,1,2-2h3a2,2,0,0,1,2,2Z" />
                <path d="M14,7h3v3a1,1,0,0,0,2,0V7h3a1,1,0,0,0,0-2H19V2a1,1,0,0,0-2,0V5H14a1,1,0,0,0,0,2Z" />
            </svg>
            <span class="text-gray-500 font-medium text-[15px]">منو</span>
        </div>
        <div @click="cart_redirect" class="w-1/4 flex items-center justify-between group flex-col gap-[6px] py-3 pb-2 cursor-pointer">
            <svg xmlns="http://www.w3.org/2000/svg" class="size-[21px] fill-gray-500" viewBox="0 0 24 24" width="512"
                height="512">
                <path
                    d="M23.27,9.03c-.57-.66-1.4-1.03-2.27-1.03h-.09C20.41,3.51,16.59,0,11.97,0S3.52,3.51,3.02,8h-.05c-.87,0-1.7,.38-2.27,1.03C.13,9.69-.12,10.56,0,11.42l1.06,7.42c.42,2.94,2.97,5.15,5.94,5.15h9.97c2.97,0,5.52-2.21,5.94-5.15l1.06-7.42c.12-.86-.13-1.73-.7-2.39ZM11.97,2c3.52,0,6.44,2.61,6.93,6H5.04c.49-3.39,3.41-6,6.93-6Zm10.02,9.14l-1.06,7.42c-.28,1.96-1.98,3.43-3.96,3.43H7c-1.98,0-3.68-1.48-3.96-3.43l-1.06-7.42c-.04-.29,.04-.57,.23-.8,.19-.22,.46-.35,.76-.35H21c.29,0,.56,.12,.75,.34,.19,.22,.28,.51,.23,.8Z" />
            </svg>
            <span class="text-gray-500 font-medium text-[15px]">سبد خرید</span>
        </div>
        <div class="w-1/4 flex items-center justify-between group flex-col gap-[6px] py-3 pb-2"
            v-if="userStore.user_loading">
            <div class="size-[30px] rounded-full bg-gray-300 animate-pulse"></div>
            <p class="w-[50%] rounded-full h-[8px] bg-gray-300 animate-pulse"></p>
        </div>
        <nuxt-link v-else-if="!userStore.isLoggedIn()" to="/auth"
            class="w-1/4 flex items-center justify-between group flex-col gap-[6px] py-3 pb-2">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                class="size-[21px] transform-[scale(1.140)] text-gray-500">
                <g stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.75"
                    clip-path="url(#account_svg__a)">
                    <path
                        d="M12 13.8c3.06 0 5.54-2.42 5.54-5.4C17.54 5.42 15.06 3 12 3S6.46 5.42 6.46 8.4c0 2.98 2.48 5.4 5.54 5.4ZM6 21c2.69-4.42 9.24-4.44 11.97-.05L18 21">
                    </path>
                </g>
                <defs>
                    <clipPath id="account_svg__a">
                        <path fill="#fff" d="M0 0h24v24H0z"></path>
                    </clipPath>
                </defs>
            </svg>
            <span class="text-gray-500 font-medium text-[15px]">ورود به حساب</span>
        </nuxt-link>
        <nuxt-link v-else to="/panel" class="w-1/4 flex items-center justify-between group flex-col gap-[6px] py-3 pb-2">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                class="size-[21px] transform-[scale(1.140)] text-gray-500">
                <g stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.75"
                    clip-path="url(#account_svg__a)">
                    <path
                        d="M12 13.8c3.06 0 5.54-2.42 5.54-5.4C17.54 5.42 15.06 3 12 3S6.46 5.42 6.46 8.4c0 2.98 2.48 5.4 5.54 5.4ZM6 21c2.69-4.42 9.24-4.44 11.97-.05L18 21">
                    </path>
                </g>
                <defs>
                    <clipPath id="account_svg__a">
                        <path fill="#fff" d="M0 0h24v24H0z"></path>
                    </clipPath>
                </defs>
            </svg>
            <span class="text-gray-500 font-medium text-[15px]">پروفایل</span>
        </nuxt-link>
    </div>
    <BottomShitDrp v-model="bottomSheet">
        <div class="w-full center flex-col">
            <Logo />
            <div class="w-full flex items-center justify-start flex-col gap-[7px] pb-7">
                <MenuBrItemDrp v-model:sheet="bottomSheet" title="دسته بندی" keyItem="category"
                    :list="menu_data.categorys">
                    <svg xmlns="http://www.w3.org/2000/svg" id="Outline" viewBox="0 0 24 24"
                        class="size-[16px] fill-title transform-[translateY(-1px)] ml-1">
                        <rect y="11" width="24" height="2" rx="1" />
                        <rect y="4" width="24" height="2" rx="1" />
                        <rect y="18" width="24" height="2" rx="1" />
                    </svg>
                </MenuBrItemDrp>

                <MenuBrItemDrp v-model:sheet="bottomSheet" title="برند ها" keyItem="brand" :list="menu_data.brands">
                    <svg xmlns="http://www.w3.org/2000/svg" id="Layer_1" data-name="Layer 1" viewBox="0 0 24 24"
                        class="size-[16px] fill-title transform-[translateY(-1px)]">
                        <path
                            d="m22.576,12.52L13.849,3.85c-.842-.835-2.046-1.243-3.221-1.09l-5.803.651L1.707.293C1.316-.098.684-.098.293.293S-.098,1.316.293,1.707l3.118,3.118-.696,6.088c-.091,1.142.323,2.258,1.136,3.062l8.713,8.645c.91.906,2.118,1.404,3.4,1.404h.02c1.29-.005,2.5-.513,3.408-1.431l3.21-3.242c1.87-1.89,1.859-4.955-.025-6.832Zm-1.396,5.426l-3.21,3.242c-.531.537-1.239.834-1.994.837h-.011c-.751,0-1.458-.292-1.992-.823L5.259,12.555c-.394-.39-.594-.93-.554-1.449l.512-4.474,1.857,1.857c-.044.164-.074.334-.074.512,0,1.105.895,2,2,2s2-.895,2-2-.895-2-2-2c-.178,0-.347.031-.512.074l-1.854-1.854,4.226-.474.021-.003c.568-.075,1.151.122,1.559.525l8.726,8.668c1.105,1.102,1.112,2.899.015,4.009Zm-3.974-5.151c-.391-.391-1.023-.391-1.414,0l-3,3c-.391.391-.391,1.023,0,1.414l2.5,2.5c.195.195.451.293.707.293s.512-.098.707-.293l3-3c.391-.391.391-1.023,0-1.414l-2.5-2.5Zm-1.207,4.793l-1.086-1.086,1.586-1.586,1.086,1.086-1.586,1.586Z" />
                    </svg>
                </MenuBrItemDrp>

                <nuxt-link to="/products" @click="bottomSheet.close()"
                    class="w-full py-1 flex items-center justify-start gap-1 text-title text-[15px] font-medium">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"
                        class="size-[16px] fill-title transform-[translateY(-1px)]">
                        <path
                            d="M24,10a.988.988,0,0,0-.024-.217l-1.3-5.868A4.968,4.968,0,0,0,17.792,0H6.208a4.968,4.968,0,0,0-4.88,3.915L.024,9.783A.988.988,0,0,0,0,10v1a3.984,3.984,0,0,0,1,2.643V19a5.006,5.006,0,0,0,5,5H18a5.006,5.006,0,0,0,5-5V13.643A3.984,3.984,0,0,0,24,11ZM2,10.109l1.28-5.76A2.982,2.982,0,0,1,6.208,2H7V5A1,1,0,0,0,9,5V2h6V5a1,1,0,0,0,2,0V2h.792A2.982,2.982,0,0,1,20.72,4.349L22,10.109V11a2,2,0,0,1-2,2H19a2,2,0,0,1-2-2,1,1,0,0,0-2,0,2,2,0,0,1-2,2H11a2,2,0,0,1-2-2,1,1,0,0,0-2,0,2,2,0,0,1-2,2H4a2,2,0,0,1-2-2ZM18,22H6a3,3,0,0,1-3-3V14.873A3.978,3.978,0,0,0,4,15H5a3.99,3.99,0,0,0,3-1.357A3.99,3.99,0,0,0,11,15h2a3.99,3.99,0,0,0,3-1.357A3.99,3.99,0,0,0,19,15h1a3.978,3.978,0,0,0,1-.127V19A3,3,0,0,1,18,22Z" />
                    </svg>
                    فروشگاه
                </nuxt-link>
                <div @click="toast.warning('این بخش هنوز راه اندازی نشده')"
                    class="w-full py-1 flex items-center justify-start gap-1 text-title text-[15px] font-medium cursor-pointer">
                    سوالی دارید؟
                </div>
                <div @click="toast.warning('این بخش هنوز راه اندازی نشده')"
                    class="w-full py-1 flex items-center justify-start gap-1 text-title text-[15px] font-medium cursor-pointer">
                    فروشنده شوید
                </div>
            </div>
            <p class="w-full text-center text-[14px] text-gray-300 pb-4">store app - v.0.1</p>
        </div>
    </BottomShitDrp>
</template>