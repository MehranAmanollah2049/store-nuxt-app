import { defineStore } from 'pinia'
import { useToken } from '~/stores/auth/useToken';
import { useUser } from '~/stores/auth/useUser';
import { usePath } from '~/stores/usePath';
import toast from 'vue-toast-next';

export const useAuth = defineStore('auth', () => {

    const tokenStore = useToken();
    const userStore = useUser();
    const pathStore = usePath();
   
    const phone_number = ref('')

    let verify_access = ref(false);
    let register_access = ref(false);


    let clear_access = () => {
        verify_access.value = false;
        register_access.value = false;
    }

    let set_verify_access = () => {
        clear_access()
        verify_access.value = true
    }

    let set_register_access = () => {
        clear_access()
        register_access.value = true
    }

    const login = (token, user) => {
        tokenStore.setToken(token);
        userStore.user = user;

        toast.success(`${user.name} عزیز , خوش آمدید`)

        clear_access()

        return navigateTo(pathStore.prev)
    }

    return { phone_number, verify_access, register_access, set_verify_access, set_register_access, login }
})