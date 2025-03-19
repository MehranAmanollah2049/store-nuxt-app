<script setup>
import toast from 'vue-toast-next';


const { $HttpRequest } = useNuxtApp()
const route = useRoute()

let isLoading = ref(true)
let data = ref([]);

const get_data = async () => {
    await $HttpRequest(`/panel/orders/${route.params.id}`)
        .then(res => {
            isLoading.value = false;

            if (res) {
                data.value = res.data
            }
        })
        .catch(err => {
            isLoading.value = false;
            navigateTo('/panel/orders')
        })
}

let total_price = computed(() => {
    return data.value.products.reduce((total, current) => {
        if (current.price) {
            return total + (current.price * current.count);
        }
        else {
            return total + (current.payment * current.count);
        }
    }, 0);
})

let total_discount = computed(() => {
    return data.value.products.reduce((total, current) => {
        if (current.discount) {
            return total + ((current.price - current.payment) * current.count);
        }

        return total
    }, 0);
})

let total_payment = computed(() => {
    return data.value.products.reduce((total, current) => {
        return total + (current.payment * current.count);
    }, 0);
})

const delete_cart = (id) => {
    data.value.products = data.value.products.filter(item => item.id != id)
}


onMounted(async () => {
    await get_data()
})


// payment
const { start, finish } = useLoadingIndicator()
const is_payment_Loading = ref(false)

const payment_handler = () => {

    if (data.value.status != 'پرداخت نشده') {
        return toast.error("امکان اجرای این عملیات وجود ندارد")
    }

    if (!is_payment_Loading.value) {
        is_payment_Loading.value = true
        start()

        $HttpRequest(`/panel/orders/${route.params.id}/payment`, {
            method: 'POST'
        })
            .then(res => {
                is_payment_Loading.value = false;
                finish()

                if (res) {

                    toast.loading("در حال انتقال به درگاه")

                    window.location.href = JSON.parse(res).action
                }
            })
            .catch(err => {
                is_payment_Loading.value = false;
                finish()
            })
    }

}

</script>


<template>
    <div class="w-full bg-white rounded-xl px-10 py-7 max-[500px]:px-5">

        <div class="w-full flex items-center justify-between mb-8 max-[340px]:flex-col gap-4">
            <p
                class="font-heavy text-[20px] max-[500px]:text-[18px] text-theme pr-5 center relative after:size-2 after:rounded-full after:bg-theme after:absolute after:content-[''] after:transform-[translateY(-0.5px)] after:right-0">
                جزییات سفارش</p>

            <div class="w-[70px] h-[13px] bg-gray-200 rounded-full animation-pluse" v-if="isLoading"></div>
            <div class="h-[28px] px-3 font-medium rounded-full text-[15px] center" v-else :class="{
                'bg-[#00c07318] text-[#00c073]': data.status == 'پرداخت شده',
                'bg-[#ed19431a] text-[#ed1943]': data.status == 'پرداخت نشده',
            }">{{ data.status }}</div>
        </div>

        <div class="w-full center flex-wrap gap-y-4 border-b border-gray-200/60 pb-6">
            <div class="w-1/4 flex items-start justify-center flex-col max-[800px]:w-2/4 max-[400px]:w-full">
                <p class="text-[15px] font-medium text-gray-400"># کد تراکنش</p>
                <span class="w-[60px] h-[13px] bg-gray-200 animation-pluse rounded-full mt-1" v-if="isLoading"></span>
                <span class="text-[17px] font-bold text-title" v-else>{{ data.code }}</span>
            </div>
            <div class="w-1/4 flex items-start justify-center flex-col max-[800px]:w-2/4 max-[400px]:w-full">
                <p class="text-[15px] font-medium text-gray-400">تاریخ</p>
                <span class="w-[60px] h-[13px] bg-gray-200 animation-pluse rounded-full mt-1" v-if="isLoading"></span>
                <span class="text-[17px] font-bold text-title" v-else>{{ data.created_at }}</span>
            </div>
            <div class="w-1/4 flex items-start justify-center flex-col max-[800px]:w-2/4 max-[400px]:w-full">
                <p class="text-[15px] font-medium text-gray-400">شماره موبایل</p>
                <span class="w-[60px] h-[13px] bg-gray-200 animation-pluse rounded-full mt-1" v-if="isLoading"></span>
                <span class="text-[17px] font-bold text-title" v-else>{{ data.phone }}</span>
            </div>
            <div class="w-1/4 flex items-start justify-center flex-col max-[800px]:w-2/4 max-[400px]:w-full">
                <p class="text-[15px] font-medium text-gray-400">تحویل گیرنده</p>
                <span class="w-[60px] h-[13px] bg-gray-200 animation-pluse rounded-full mt-1" v-if="isLoading"></span>
                <span class="text-[17px] font-bold text-title" v-else>{{ data.full_name }}</span>
            </div>
        </div>
        <div class="w-full center flex-wrap gap-y-4 pt-6 pb-3">
            <div class="w-1/4 flex items-start justify-center flex-col max-[800px]:w-2/4 max-[400px]:w-full">
                <p class="text-[15px] font-medium text-gray-400">جمع کل</p>
                <span class="w-[60px] h-[13px] bg-gray-200 animation-pluse rounded-full mt-1" v-if="isLoading"></span>
                <span class="text-[17px] font-bold text-title" v-else>{{ total_price.toLocaleString() }} تومان</span>
            </div>
            <div class="w-1/4 flex items-start justify-center flex-col max-[800px]:w-2/4 max-[400px]:w-full">
                <p class="text-[15px] font-medium text-gray-400">سود شما</p>
                <span class="w-[60px] h-[13px] bg-gray-200 animation-pluse rounded-full mt-1" v-if="isLoading"></span>
                <span class="text-[17px] font-bold text-title" v-else>{{ total_discount.toLocaleString() }} تومان</span>
            </div>
            <div class="w-1/4 flex items-start justify-center flex-col max-[800px]:w-2/4 max-[400px]:w-full">
                <p class="text-[15px] font-medium text-gray-400"> {{ data.status == 'پرداخت نشده' ? 'قابل پرداخت' : 'پرداخت شده ' }} </p>
                <span class="w-[60px] h-[13px] bg-gray-200 animation-pluse rounded-full mt-1" v-if="isLoading"></span>
                <span class="text-[17px] font-bold text-title" v-else>{{ total_payment.toLocaleString() }} تومان</span>
            </div>
            <div class="w-1/4 flex items-start justify-center flex-col max-[800px]:w-2/4 max-[400px]:w-full">
                <p class="text-[15px] font-medium text-gray-400">درگاه پرداخت</p>
                <span class="w-[60px] h-[13px] bg-gray-200 animation-pluse rounded-full mt-1" v-if="isLoading"></span>
                <span class="text-[17px] font-bold text-title" v-else>{{ data.driver }}</span>
            </div>
        </div>
    </div>
    <div class="w-full bg-white rounded-xl px-10 py-7 mt-7 max-[500px]:px-5">
        <div class="w-full flex items-center justify-between mb-8 max-[450px]:flex-col max-[450px]:gap-4">
            <p
                class="font-heavy text-[20px] max-[500px]:text-[18px] text-theme pr-5 center relative after:size-2 after:rounded-full after:bg-theme after:absolute after:content-[''] after:transform-[translateY(-0.5px)] after:right-0">
                کالا های سفارشی</p>

            <div class="btn-theme !w-auto center transition-custom w-full h-[45px] rounded-lg text-[15px] font-bold max-[450px]:!w-full"
                v-if="data.status == 'پرداخت نشده'" @click="payment_handler" :class="{
                    'pointer-events-none bg-theme': is_payment_Loading
                }">
                <Loading v-if="is_payment_Loading" theme="white" />
                <template v-else>
                    نهایی سازی سفارش
                </template>
            </div>
        </div>

        <div class="w-full center flex-col gap-3">
            <template v-if="isLoading">
                <ProductLikeBoxLoading />
                <ProductLikeBoxLoading />
                <ProductLikeBoxLoading />
            </template>
            <template v-if="data.status == 'پرداخت شده'">
                <OrderSuccessProduct v-for="product in data.products" :key="product.id" :product="product" />
            </template>
            <template v-else>
                <CartProduct :is_order="true" :request="`panel/orders/${data.id}/${product.id}`" v-for="product in data.products"
                    :key="product.id" :product="product" @delete_cart="delete_cart"
                    :is_available="product.count <= product.total" />
            </template>
        </div>
    </div>
</template>