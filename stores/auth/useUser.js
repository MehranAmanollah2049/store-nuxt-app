import { defineStore } from "pinia";
import { useToken } from "~/stores/auth/useToken";

export const useUser = defineStore('user', () => {

    const tokenStore = useToken()
    const user = ref(null);

    // loadings
    let user_loading = ref(false);
    let user_logout_loading = ref(false);

    let load_user = () => {
        if (tokenStore.getToken()) {
            user_loading.value = true
            useNuxtApp().$HttpRequest('/auth/user')
                .then(res => {
                    user_loading.value = false
                    if (res) {
                        user.value = res.user;
                    }
                })
                .catch(err => {
                    user_loading.value = false;
                })
        }
    }


    const logout = () => {
        if (!user_logout_loading.value) {
            user_logout_loading.value = true;

            useNuxtApp().$HttpRequest('/auth/logout', {
                method: 'DELETE'
            })
                .then(res => {
                    user_logout_loading.value = false;

                    if (res) {
                        deleteData()
                    }
                })
        }
    }


    const deleteData = () => {
        user.value = null;
        tokenStore.removeToken();
    }

    const isLoggedIn = () => tokenStore.getToken() && user.value

    const increase_cart = () => user.value.cart++
    const decrease_cart = () => user.value.cart--

    return { user, user_loading , user_logout_loading , load_user, logout, isLoggedIn, deleteData , increase_cart , decrease_cart }

})