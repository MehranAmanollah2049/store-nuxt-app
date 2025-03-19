<script setup>

const form_config = defineModel()
const text = defineModel('text')
const score = defineModel('score')

const toggle_score = (value) => {
    if (score.value == value) {
        score.value = ''
    }
    else {
        score.value = value
    }
}

</script>

<template>
    <div class="fixed inset-0 bg-[#0000004f] z-200 center opacity-0 invisible transition-custom" :class="{
        'opacity-100 visible': form_config.active
    }">
        <div class="fixed inset-0 z-1" @click="form_config.active = false"></div>
        <div class="w-[550px] max-[600px]:w-full max-[600px]:h-screen max-[600px]:max-h-screen max-[600px]:rounded-none flex items-center justify-between flex-col py-2 px-6  relative bg-white rounded-lg z-2 overflow-y-auto max-h-[calc(100vh-50px)] scrollbar-hide">
            <div class="w-full">
                <div class="w-full flex items-center justify-between py-3 border-b border-gray-200/70">
                    <p class="text-title font-medium text-[18px]">{{ form_config.title }}</p>
                    <svg fill="none" stroke-width="0" viewBox="0 0 24 24" @click="form_config.active = false"
                        class="size-5 text-gray-500 transform-[translateY(-1px)] cursor-pointer" height="20" width="20"
                        xmlns="http://www.w3.org/2000/svg">
                        <path
                            d="M6.2253 4.81108C5.83477 4.42056 5.20161 4.42056 4.81108 4.81108C4.42056 5.20161 4.42056 5.83477 4.81108 6.2253L10.5858 12L4.81114 17.7747C4.42062 18.1652 4.42062 18.7984 4.81114 19.1889C5.20167 19.5794 5.83483 19.5794 6.22535 19.1889L12 13.4142L17.7747 19.1889C18.1652 19.5794 18.7984 19.5794 19.1889 19.1889C19.5794 18.7984 19.5794 18.1652 19.1889 17.7747L13.4142 12L19.189 6.2253C19.5795 5.83477 19.5795 5.20161 19.189 4.81108C18.7985 4.42056 18.1653 4.42056 17.7748 4.81108L12 10.5858L6.2253 4.81108Z"
                            fill="currentColor"></path>
                    </svg>
                </div>
                <div class="w-full center flex-col gap-5 py-5 pt-7 px-10  max-[600px]:px-0">
                    <div class="w-full center flex-col gap-2 border-b border-gray-200/70 pb-4" v-if="form_config.score_status">
                        <p class="text-title font-medium text-[17px] w-full">امتیاز شما</p>
                        <div class="w-full center gap-2">
                            <ScoreBox @click="toggle_score('پیشنهاد نمی کنم')" title="پیشنهاد نمی کنم" :score="score">
                                <template #icon="props">
                                    <svg stroke="currentColor" fill="currentColor" stroke-width="0"
                                        viewBox="0 0 1024 1024" class="w-8 h-8 transition-custom" :class="{
                                            'text-theme': props.score == props.title
                                        }" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
                                        <path
                                            d="M885.9 490.3c3.6-12 5.4-24.4 5.4-37 0-28.3-9.3-55.5-26.1-77.7 3.6-12 5.4-24.4 5.4-37 0-28.3-9.3-55.5-26.1-77.7 3.6-12 5.4-24.4 5.4-37 0-51.6-30.7-98.1-78.3-118.4a66.1 66.1 0 0 0-26.5-5.4H144c-17.7 0-32 14.3-32 32v364c0 17.7 14.3 32 32 32h129.3l85.8 310.8C372.9 889 418.9 924 470.9 924c29.7 0 57.4-11.8 77.9-33.4 20.5-21.5 31-49.7 29.5-79.4l-6-122.9h239.9c12.1 0 23.9-3.2 34.3-9.3 40.4-23.5 65.5-66.1 65.5-111 0-28.3-9.3-55.5-26.1-77.7zM184 456V172h81v284h-81zm627.2 160.4H496.8l9.6 198.4c.6 11.9-4.7 23.1-14.6 30.5-6.1 4.5-13.6 6.8-21.1 6.7a44.28 44.28 0 0 1-42.2-32.3L329 459.2V172h415.4a56.85 56.85 0 0 1 33.6 51.8c0 9.7-2.3 18.9-6.9 27.3l-13.9 25.4 21.9 19a56.76 56.76 0 0 1 19.6 43c0 9.7-2.3 18.9-6.9 27.3l-13.9 25.4 21.9 19a56.76 56.76 0 0 1 19.6 43c0 9.7-2.3 18.9-6.9 27.3l-14 25.5 21.9 19a56.76 56.76 0 0 1 19.6 43c0 19.1-11 37.5-28.8 48.4z">
                                        </path>
                                    </svg>
                                </template>
                            </ScoreBox>
                            <ScoreBox @click="toggle_score('مطمئن نیستم')" title='مطمئن نیستم' :score="score">
                                <template #icon="props">
                                    <svg stroke="currentColor" fill="none" stroke-width="2" viewBox="0 0 24 24"
                                        stroke-linecap="round" stroke-linejoin="round"
                                        class="w-8 h-8 text-gray-400 transition-custom" :class="{
                                            'text-theme': props.score == props.title
                                        }" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
                                        <desc></desc>
                                        <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                        <circle cx="9" cy="7" r="4"></circle>
                                        <path d="M3 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2"></path>
                                        <line x1="19" y1="7" x2="19" y2="10"></line>
                                        <line x1="19" y1="14" x2="19" y2="14.01"></line>
                                    </svg>
                                </template>
                            </ScoreBox>
                            <ScoreBox @click="toggle_score('پیشنهاد می کنم')" title="پیشنهاد می کنم" :score="score">
                                <template #icon="props">
                                    <svg fill="currentColor" stroke-width="0" viewBox="0 0 1024 1024"
                                        class="w-8 h-8 transition-custom" :class="{
                                            '!text-theme': props.score == props.title
                                        }" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
                                        <path
                                            d="M885.9 533.7c16.8-22.2 26.1-49.4 26.1-77.7 0-44.9-25.1-87.4-65.5-111.1a67.67 67.67 0 0 0-34.3-9.3H572.4l6-122.9c1.4-29.7-9.1-57.9-29.5-79.4A106.62 106.62 0 0 0 471 99.9c-52 0-98 35-111.8 85.1l-85.9 311H144c-17.7 0-32 14.3-32 32v364c0 17.7 14.3 32 32 32h601.3c9.2 0 18.2-1.8 26.5-5.4 47.6-20.3 78.3-66.8 78.3-118.4 0-12.6-1.8-25-5.4-37 16.8-22.2 26.1-49.4 26.1-77.7 0-12.6-1.8-25-5.4-37 16.8-22.2 26.1-49.4 26.1-77.7-.2-12.6-2-25.1-5.6-37.1zM184 852V568h81v284h-81zm636.4-353l-21.9 19 13.9 25.4a56.2 56.2 0 0 1 6.9 27.3c0 16.5-7.2 32.2-19.6 43l-21.9 19 13.9 25.4a56.2 56.2 0 0 1 6.9 27.3c0 16.5-7.2 32.2-19.6 43l-21.9 19 13.9 25.4a56.2 56.2 0 0 1 6.9 27.3c0 22.4-13.2 42.6-33.6 51.8H329V564.8l99.5-360.5a44.1 44.1 0 0 1 42.2-32.3c7.6 0 15.1 2.2 21.1 6.7 9.9 7.4 15.2 18.6 14.6 30.5l-9.6 198.4h314.4C829 418.5 840 436.9 840 456c0 16.5-7.2 32.1-19.6 43z">
                                        </path>
                                    </svg>
                                </template>
                            </ScoreBox>
                        </div>
                    </div>
                    <div class="w-full center flex-col gap-2">
                        <p class="text-title font-medium text-[17px] w-full">متن دیدگاه</p>
                        <textarea placeholder="متن خود را اینجا بنویسید..." v-model="text"
                            class="w-full h-[180px] bg-gray-100 rounded-md resize-none p-4 text-[15px] text-title transition-custom border border-transparent focus:bg-white  focus:border-theme focus:shadow-theme-150"></textarea>
                    </div>
                </div>
            </div>

            <div class="w-full center px-10 pb-5 max-[600px]:px-0">
                <div class="btn-theme text-[15px] w-full h-[47px] transition-custom center" :class="{
                    'pointer-events-none bg-theme': form_config.loading
                }" @click="form_config.event">
                    <Loading v-if="form_config.loading" theme="white" />
                    <template v-else>
                        افزودن دیدگاه
                    </template>
                </div>
            </div>
        </div>
    </div>
</template>