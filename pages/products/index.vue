<script setup>

const { $HttpRequest } = useNuxtApp()

const router = useRoute()
const route = useRouter()

const menu_data = inject("menu_data");
const menu_data_loading = inject("menu_data_loading");
const max_price = ref(150000000)

const current_page = ref(1)
const products_loading = ref(false)
const products = ref({
    data: [],
    pagination: {
        total: 1,
        current: 1
    }
})

const filter = ref({
    search: router.query.search ?? '',
    categorys: router.query.category ? [Number(router.query.category)] : [],
    brands: router.query.brand ? [Number(router.query.brand)] : [],
    price: [0, max_price.value],
    orderBy: router.query.orderBy ?? '',
})


const fetchData = async () => {
    const { categorys, brands, price, orderBy, search } = filter.value;

    const params = new URLSearchParams({
        categorys: JSON.stringify(categorys),
        brands: JSON.stringify(brands),
        price_min: price[0],
        price_max: price[1],
        orderBy,
        search,
        page: current_page.value,
        perPage: 12
    });

    if (!products_loading.value) {
        products_loading.value = true
        await $HttpRequest(`/products?${params.toString()}`)
            .then(res => {
                products_loading.value = false;
                products.value = res
            })
    }

}

const is_normal_filters_active = computed(() => filter.value.search != '' || filter.value.categorys.length != 0 || filter.value.brands.length != 0 || filter.value.price[0] != 0 || filter.value.price[1] != max_price.value);
const is_orerBy_active = computed(() => filter.value.orderBy != '');

const clearFilter = () => {
    filter.value = {
        search: '',
        categorys: [],
        brands: [],
        price: [0, max_price.value],
        orderBy: ''
    }

    route.replace({ path: '/products' })
}

const next_page = () => {

    if (products.value.pagination.current >= products.value.pagination.total) {
        return
    }

    current_page.value = ++products.value.pagination.current;
    fetchData()

    document.documentElement.scrollTop = 0
}

const prev_page = () => {

    if (products.value.pagination.current == 1) {
        return
    }

    current_page.value = --products.value.pagination.current;
    fetchData()

    document.documentElement.scrollTop = 0
}

let debounceTimeout = null;

watch(filter, () => {
    if (debounceTimeout) {
        clearTimeout(debounceTimeout);
    }

    debounceTimeout = setTimeout(() => {
        current_page.value = 1
        fetchData()
    }, 380);
}, { deep: true });

watch(() => router.query, () => {
    if (router.query.search) {
        filter.value.search = router.query.search
    }

    if (router.query.category) {
        filter.value.categorys = [Number(router.query.category)]
    }

    if (router.query.brand) {
        filter.value.brands = [Number(router.query.brand)]
    }

    if (router.query.orderBy) {
        filter.value.orderBy = router.query.orderBy
    }

}, { deep: true })

onMounted(async () => await fetchData())

const filter_sheet = ref(null)
const orderBy_sheet = ref(null)

</script>

<template>
    <div class="w-full center py-10 pt-20 max-[900px]:pt-10">
        <div class="w-custom flex items-start justify-between">
            <div
                class="w-8/35 max-[1190px]:w-9/35 max-[1010px]:w-10/35 max-[900px]:hidden rounded-lg p-4 border border-gray-100">
                <div class="w-full flex items-center justify-between">
                    <p class="text-[20px] font-bold text-title">فیلتر ها</p>
                    <div class="text-[15px] text-theme font-medium cursor-pointer"
                        v-if="is_normal_filters_active || is_orerBy_active" @click="clearFilter">پاک کردن فیلتر ها</div>
                </div>
                <div class="w-full center flex-col pt-5">
                    <FilterBox title="دسته بندی">
                        <template v-if="!menu_data_loading">
                            <CheckBoxItem v-for="item in menu_data.categorys" :key="item.id" :data="item" selector="id"
                                v-model="filter.categorys" />
                        </template>
                        <template v-else>
                            <div class="w-full h-[50px] center">
                                <Loading />
                            </div>
                        </template>
                    </FilterBox>
                    <FilterBox title="برند ها">
                        <template v-if="!menu_data_loading">
                            <CheckBoxItem v-for="item in menu_data.brands" :key="item.id" :data="item" selector="id"
                                v-model="filter.brands" />
                        </template>
                        <template v-else>
                            <div class="w-full h-[50px] center">
                                <Loading />
                            </div>
                        </template>
                    </FilterBox>
                    <FilterBox title="محدوده قیمت">
                        <PriceHandler v-model="filter.price" :max_price="max_price" />
                    </FilterBox>
                    <FilterBox title="مرتب سازی" class="border-b-transparent">
                        <RadioBox :data="{ id: 1, title: 'جدیدترین ها', value: 'news' }" selector="value"
                            v-model="filter.orderBy" />
                        <RadioBox :data="{ id: 1, title: 'قدیمی ترین ها', value: 'olds' }" selector="value"
                            v-model="filter.orderBy" />
                        <RadioBox :data="{ id: 1, title: 'محبوب ترین ها', value: 'populars' }" selector="value"
                            v-model="filter.orderBy" />
                    </FilterBox>
                </div>
            </div>
            <div class="w-26/35 max-[1190px]:w-25/35 max-[1010px]:w-24/35  max-[900px]:w-full">
                <div
                    class="w-full gap-2 hidden max-[900px]:flex max-[900px]:items-center max-[900px]:justify-center pb-5">
                    <div @click="filter_sheet.open()"
                        class="w-1/2 h-[43px] rounded-xl center gap-1 border border-gray-200/70 text-title text-[15px] font-bold cursor-pointer">
                        <svg stroke="currentColor" fill="none" stroke-width="0" viewBox="0 0 24 24"
                            class="w-5 h-5 text-gray-400 ml-2" height="1em" width="1em"
                            xmlns="http://www.w3.org/2000/svg">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4">
                            </path>
                        </svg>
                        فیلتر محصولات
                    </div>
                    <div @click="orderBy_sheet.open()"
                        class="w-1/2 h-[43px] rounded-xl center gap-1 border border-gray-200/70 text-title text-[15px] font-bold cursor-pointer">
                        <svg stroke="currentColor" fill="none" stroke-width="0" viewBox="0 0 24 24"
                            class="w-5 h-5 text-gray-400 ml-2" height="1em" width="1em"
                            xmlns="http://www.w3.org/2000/svg">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M3 4h13M3 8h9m-9 4h9m5-4v12m0 0l-4-4m4 4l4-4"></path>
                        </svg>
                        مرتب سازی
                    </div>
                </div>
                <div
                    class="w-full grid grid-cols-4 max-[1190px]:grid-cols-3 max-[1010px]:grid-cols-2 max-[900px]:grid-cols-3 max-[700px]:grid-cols-2 max-[400px]:grid-cols-1">
                    <template v-if="products_loading">
                        <ProductCardLoading />
                        <ProductCardLoading />
                        <ProductCardLoading />
                        <ProductCardLoading />
                        <ProductCardLoading />
                        <ProductCardLoading />
                        <ProductCardLoading />
                        <ProductCardLoading />
                    </template>
                    <template v-else-if="products">
                        <ProductCard v-for="product in products.data" :key="product.id" :product="product" />
                    </template>
                </div>
                <div class="w-full flex items-center justify-between pt-8"
                    v-if="products && products.pagination.total > 1">
                    <div class="btn-title transition-custom center"
                        :class="{ 'pointer-events-none opacity-40': products.pagination.current <= 1 }"
                        @click="prev_page">
                        صفحه قبلی
                    </div>
                    <div class="btn-title transition-custom center"
                        :class="{ 'pointer-events-none opacity-40': products.pagination.current >= products.pagination.total }"
                        @click="next_page">
                        صفحه بعدی
                    </div>
                </div>
                <div class="w-full py-15 center flex-col gap-3 py-3 font-bold text-gray-600"
                    v-if="products.data.length == 0 && !products_loading">
                    <img src="~/assets/image/empty-cart.svg" alt="">
                    موردی یافت نشده
                </div>
            </div>
        </div>
    </div>
    <BottomShitDrp v-model="filter_sheet">

        <div class="w-full center flex-col">
            <div class="w-full flex items-center justify-between py-2">
                <p class="text-[20px] font-bold text-title">فیلتر ها</p>
                <div class="text-[15px] text-theme font-medium cursor-pointer"
                    v-if="is_normal_filters_active || is_orerBy_active" @click="clearFilter">پاک کردن فیلتر ها</div>
            </div>
            <FilterBox title="دسته بندی" :default="false">
                <template v-if="!menu_data_loading">
                    <CheckBoxItem v-for="item in menu_data.categorys" :key="item.id" :data="item" selector="id"
                        v-model="filter.categorys" />
                </template>
                <template v-else>
                    <div class="w-full h-[50px] center">
                        <Loading />
                    </div>
                </template>
            </FilterBox>
            <FilterBox title="برند ها" :default="false">
                <template v-if="!menu_data_loading">
                    <CheckBoxItem v-for="item in menu_data.brands" :key="item.id" :data="item" selector="id"
                        v-model="filter.brands" />
                </template>
                <template v-else>
                    <div class="w-full h-[50px] center">
                        <Loading />
                    </div>
                </template>
            </FilterBox>
            <FilterBox title="محدوده قیمت" :default="false" class="border-b-transparent">
                <PriceHandler v-model="filter.price" :max_price="max_price" />
            </FilterBox>
            <p class="w-full text-center text-[14px] pt-5 text-gray-300 pb-4">store app - v.0.1</p>
        </div>
    </BottomShitDrp>
    <BottomShitDrp v-model="orderBy_sheet">
        <div class="w-full flex items-center justify-between py-2">
            <p class="text-[20px] font-bold text-title">فیلتر ها</p>
            <div class="text-[15px] text-theme font-medium cursor-pointer"
                v-if="is_normal_filters_active || is_orerBy_active" @click="clearFilter">پاک کردن فیلتر ها</div>
        </div>
        <div class="w-full center flex-col">
            <FilterBox title="مرتب سازی" class="border-b-transparent" :default="false">
                <RadioBox :data="{ id: 1, title: 'جدیدترین ها', value: 'news' }" selector="value"
                    v-model="filter.orderBy" />
                <RadioBox :data="{ id: 1, title: 'قدیمی ترین ها', value: 'olds' }" selector="value"
                    v-model="filter.orderBy" />
                <RadioBox :data="{ id: 1, title: 'محبوب ترین ها', value: 'populars' }" selector="value"
                    v-model="filter.orderBy" />
            </FilterBox>
            <p class="w-full text-center text-[14px] pt-5 text-gray-300 pb-4">store app - v.0.1</p>
        </div>
    </BottomShitDrp>
</template>
