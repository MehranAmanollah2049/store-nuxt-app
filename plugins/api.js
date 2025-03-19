import { useToken } from "~/stores/auth/useToken"
import { toast } from 'vue-toast-next'
import { useUser } from "~/stores/auth/useUser";

export default defineNuxtPlugin((nuxtApp) => {

  const runtimeConfig = useRuntimeConfig()
  const route = useRoute();
  let tokenStore = useToken()
  let userStore = useUser()

  const HttpRequest = $fetch.create({
    baseURL: runtimeConfig.public.BASEURL + '/api',
    onRequest({ request, options, error }) {
      options.headers.set('Accept', 'application/json')
      options.headers.set('Authorization', `Bearer ${tokenStore.getToken()}`)
    },
    async onResponseError({ response }) {
      if (response.status === 422) {
        toast.error(response._data.error)
      }
      else if (response.status === 401) {
        toast.error('خطای احراز هویت')
        userStore.deleteData()

        if (route.path.startsWith('/panel')) {
          return navigateTo('/')
        }
      }
      else if (response.status === 429) {
        userStore.deleteData()
        toast.error('بیش از حد مجاز امتحان کرده اید')
      }
      else {
        toast.error('خطایی در ارتباط با سرور بوجود اومد')
      }
    }
  })

  return {
    provide: {
      HttpRequest
    }
  }
})