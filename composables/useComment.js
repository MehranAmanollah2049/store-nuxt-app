import toast from "vue-toast-next"
import { useUser } from "~/stores/auth/useUser"

export function useComment() {

    const text = ref('')
    const score = ref('')

    const { $HttpRequest } = useNuxtApp()
    const { start, finish } = useLoadingIndicator()
    const userStore = useUser()

    const add_comment = (id, config) => {

        if (!userStore.isLoggedIn()) {
            return toast.error("ابتدا وارد حساب خود شوید")
        }

        if (text.value == '' || score.value == '') {
            return toast.error("لطفا اطلاعات خواسته شده را وارد کنید")
        }

        if (!config.loading) {
            config.loading = true
            start()

            $HttpRequest(`/add-comment/${id}`, {
                method: 'POST',
                body: {
                    text: text.value,
                    score: score.value,
                }
            })
                .then(res => {
                    config.loading = false
                    finish()
                    if (res) {
                        toast.success("دیدگاه شما بعد از تایید شدن نمایش داده می شود")
                        config.active = false
                        text.value = ''
                        score.value = ''
                    }
                })
                .catch(err => {
                    config.loading = false
                    finish()
                })
        }

    }

    const add_answer = (config,comment_id,answerable_id,answerable_type) => {

        if (!userStore.isLoggedIn()) {
            return toast.error("ابتدا وارد حساب خود شوید")
        }

        if (text.value == '') {
            return toast.error("لطفا اطلاعات خواسته شده را وارد کنید")
        }

        if (!config.loading) {
            config.loading = true
            start()

            $HttpRequest(`/add-answer/${comment_id}`, {
                method: 'POST',
                body: {
                    answerable_id,
                    answerable_type,
                    text: text.value,
                }
            })
                .then(res => {
                    config.loading = false
                    finish()
                    if (res) {
                        toast.success("دیدگاه شما بعد از تایید شدن نمایش داده می شود")
                        config.active = false
                        text.value = ''
                        score.value = ''
                    }
                })
                .catch(err => {
                    config.loading = false
                    finish()
                })
        }

    }

    return [
        text,
        score,
        add_comment,
        add_answer
    ]

}