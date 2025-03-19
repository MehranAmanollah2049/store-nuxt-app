import { useAuth } from "~/stores/auth/useAuth"

export default defineNuxtRouteMiddleware(async (to, from) => {
    
    const authStore = useAuth();

    if(!authStore.verify_access) {
        return navigateTo('/auth');
    }

})

