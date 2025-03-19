import { usePath } from "~/stores/usePath"

export default defineNuxtRouteMiddleware(async (to, from) => {
    // save prev url
    let pathStore = usePath();

    if (!to.path.startsWith('/auth')) {
        pathStore.prev = to.path
    }

    // layouts
    if(to.path.startsWith("/auth")) {
        to.meta.layout = 'auth'
    }

    if(to.path.startsWith("/panel")) {
        to.meta.layout = 'panel'
    }
})

