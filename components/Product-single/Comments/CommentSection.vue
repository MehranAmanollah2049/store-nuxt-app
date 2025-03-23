<script setup>
import toast from 'vue-toast-next'
import { useUser } from '~/stores/auth/useUser'


const userStore = useUser()
const route = useRoute()

const form_config = ref({
    title: 'دیدگاه شما',
    active: false,
    loading: false,
    score_status: true,
    event: () => false
})

const [text, score, add_comment, add_answer] = useComment()

// load comments
const { $HttpRequest } = useNuxtApp()
let isLoading = ref(false)

const comments = ref([])
const pagination = ref([])

const send_request = (page = 1) => {
    if (!isLoading.value) {
        isLoading.value = true;

        $HttpRequest(`/comments/${route.params.id}?page=${page}&perPage=8`)
            .then(res => {
                isLoading.value = false

                if (res) {
                    comments.value = res.data
                    pagination.value = res.pagination
                }
            })
            .catch(err => {
                isLoading.value = false
            })
    }
}

const add_comment_handler = () => {
    if (!userStore.isLoggedIn()) {
        return toast.error("ابتدا وارد حساب خود شوید")
    }

    form_config.value.title = 'دیدگاه شما'
    form_config.value.event = () => add_comment(route.params.id, form_config.value)
    form_config.value.score_status = true
    form_config.value.active = true
}

const add_answer_handler = (comment_id, answerable_id, answerable_type, name) => {
    if (!userStore.isLoggedIn()) {
        return toast.error("ابتدا وارد حساب خود شوید")
    }

    form_config.value.title = `پاسخ به ${name}`
    form_config.value.event = () => add_answer(form_config.value, comment_id, `${answerable_id}`, answerable_type)
    form_config.value.score_status = false
    form_config.value.active = true
}

const comment_section_elem = ref(null)

const next_page = () => {

    if (pagination.value.current >= pagination.value.total) {
        return
    }

    send_request(++pagination.value.current)

    window.scrollTo({
        top: comment_section_elem.value.offsetTop - 50,
        behavior: 'smooth'
    });
}

const prev_page = () => {

    if (pagination.value.current == 1) {
        return
    }

    send_request(--pagination.value.current)

    window.scrollTo({
        top: comment_section_elem.value.offsetTop - 50,
        behavior: 'smooth'
    });
}

onMounted(() => send_request(1))

</script>

<template>
    <div class="w-full center flex-col gap-3 pb-10" ref="comment_section_elem">
        <div class="w-full flex items-center pb-3 justify-between flex-wrap gap-3">
            <p
                class="font-heavy text-[25px] max-[650px]:text-[23px] max-[450px]:text-[21px] text-theme pr-5 center relative after:size-2 after:rounded-full after:bg-theme after:absolute after:content-[''] after:transform-[translateY(-0.5px)] after:right-0">
                امتیاز و دیدگاه کاربران</p>
            <div class="btn-title transition-custom center" @click="add_comment_handler">افزودن دیدگاه</div>
        </div>
        <div class="w-full center flex-col gap-3">
            <template v-if="isLoading">
                <CommentLoading />
                <CommentLoading />
                <CommentLoading />
                <CommentLoading />
                <CommentLoading />
                <CommentLoading />
                <CommentLoading />
                <CommentLoading />
            </template>
            <template v-else-if="comments.length == 0">
                <div class="w-full center flex-col gap-3 text-[#A2ACBF] font-medium py-13">
                    <svg width="54" height="54" viewBox="0 0 54 54" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd"
                            d="M27 0C49.2345 0 54 4.00008 54 24C54 37.0001 51.7506 45 41.6256 45C36.2147 45 34.6052 47.5703 33.1064 49.9638C31.8006 52.0491 30.5789 54.0001 27.0006 54C23.4225 53.9999 22.2007 52.049 20.8949 49.9638C19.3961 47.5703 17.7865 45 12.3756 45C2.25055 45 0 36.7442 0 24C0 4.23601 4.7655 0 27 0ZM49.5 24C49.5 13.878 48.1565 9.89799 45.8623 7.87579C44.6944 6.84628 42.8722 5.95738 39.7488 5.35647C36.6026 4.75117 32.4778 4.5 27 4.5C21.5316 4.5 17.4124 4.76523 14.2732 5.38537C11.1583 6.00072 9.32897 6.90538 8.1517 7.95184C5.83648 10.0098 4.5 14.0158 4.5 24C4.5 30.3241 5.09867 34.632 6.41592 37.2668C7.01586 38.4668 7.70279 39.1862 8.47207 39.6441C9.25959 40.1128 10.4585 40.5 12.3756 40.5C15.6095 40.5 18.2372 41.232 20.3756 42.6808C22.433 44.0748 23.6339 45.8794 24.4009 47.0862L24.7092 47.5722C25.3722 48.6189 25.5918 48.9656 25.9024 49.2444L25.9146 49.256C25.9799 49.3197 26.1644 49.5 27.0007 49.5C27.8371 49.5 28.0216 49.3197 28.0867 49.2561L28.0989 49.2445C28.4096 48.9657 28.6291 48.6191 29.2923 47.572L29.6003 47.0864C30.3672 45.8797 31.5681 44.0749 33.6255 42.6809C35.7638 41.232 38.3916 40.5 41.6256 40.5C43.5662 40.5 44.7756 40.119 45.564 39.6594C46.3265 39.2148 47.0012 38.5197 47.5916 37.3489C48.8981 34.7581 49.5 30.4669 49.5 24Z"
                            fill="#E0E3EA"></path>
                        <path
                            d="M31.5 15.75C30.2573 15.75 29.25 16.7573 29.25 18C29.25 19.2427 30.2573 20.25 31.5 20.25H38.25C39.4927 20.25 40.5 19.2427 40.5 18C40.5 16.7573 39.4927 15.75 38.25 15.75H31.5Z"
                            fill="#A2ACBF"></path>
                        <path
                            d="M15.75 24.75C14.5073 24.75 13.5 25.7573 13.5 27C13.5 28.2427 14.5073 29.25 15.75 29.25H38.25C39.4927 29.25 40.5 28.2427 40.5 27C40.5 25.7573 39.4927 24.75 38.25 24.75H15.75Z"
                            fill="#A2ACBF"></path>
                    </svg>
                    هنوز دیدگاهی ثبت نشده
                </div>
            </template>
            <template v-else>
                <LazyComment v-for="comment in comments" :key="comment.id" :data="comment"
                    @answerEvent="add_answer_handler(comment.id, comment.id, 'Comment', comment.user)">
                    <LazyComment v-for="(answer, index) in comment.answers" :key="answer.id" :data="answer"
                        :answer_mode="true" :is_last="index == comment.answers.length - 1"
                        @answerEvent="add_answer_handler(comment.id, answer.id, 'Answer', answer.user)" />
                </LazyComment>
            </template>


        </div>
        <div class="w-full flex items-center justify-between pt-2" v-if="comments && pagination.total > 1">
            <div class="btn-title transition-custom center"
                :class="{ 'pointer-events-none bg-theme opacity-40': pagination.current <= 1 }" @click="prev_page">
                صفحه قبلی
            </div>
            <div class="btn-title transition-custom center"
                :class="{ 'pointer-events-none bg-theme opacity-40': pagination.current >= pagination.total }"
                @click="next_page">
                صفحه بعدی
            </div>
        </div>
    </div>
    <LazyCommnetForm v-model="form_config" v-model:text="text" v-model:score="score" />
</template>