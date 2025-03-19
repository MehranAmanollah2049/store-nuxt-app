import { useToken } from "~/stores/auth/useToken"
import { usePath } from "~/stores/usePath"

export default defineNuxtRouteMiddleware(async (to, from) => {
    
    const pathStore = usePath();
    const tokenStore = useToken();

    if(to.path.startsWith("/auth") && tokenStore.getToken())
    {
        return navigateTo(pathStore.prev);
    }
})

