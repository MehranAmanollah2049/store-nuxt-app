import { useUser } from "~/stores/auth/useUser";
import toast from 'vue-toast-next';

export function useLike(id,tracker) {
    const { $HttpRequest } = useNuxtApp()
    const { start, finish } = useLoadingIndicator()

    const userStore = useUser();
    let isLikeLoading = ref(false)

    let likes_list = ref([])

    const load_likes = (likes) => {
        likes_list.value = likes
    }

    const has_likes = computed(() => {
        if (userStore.isLoggedIn()) {
            return likes_list.value.find(id => id == userStore?.user.id);
        }

        return false;
    })

    const handleLike = () => {

        if (!userStore.isLoggedIn()) {
            toast.error("ابتدا وارد حساب خود شوید")
            return;
        }

        if (!isLikeLoading.value) {
            isLikeLoading.value = true;
            start();

            $HttpRequest(`/like/${id}`, {
                method: 'POST'
            })
                .then(res => {
                    isLikeLoading.value = false;
                    finish()

                    if (res) {
                        if (has_likes.value) {
                            likes_list.value = likes_list.value.filter(id => id != userStore.user.id)
                        }
                        else {
                            likes_list.value.push(userStore.user.id)
                        }


                        tracker({ id, likes: [...likes_list.value] })
                    }
                })
                .catch(err => {
                    isLikeLoading.value = false;
                    finish()
                })
        }

    }

    return [
        isLikeLoading,
        handleLike,
        has_likes,
        load_likes
    ]
}