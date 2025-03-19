import { useAuth } from "~/stores/auth/useAuth"

export default defineNuxtRouteMiddleware(async (to, from) => {
    
    const authStore = useAuth();

    if(!authStore.register_access) {
        return navigateTo('/auth');
    }

})

