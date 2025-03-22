import tailwindcss from "@tailwindcss/vite";

// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  app: {
    head: {
      title: 'دیجینو',
      htmlAttrs: {
        lang: 'en',
      },
    }
  },
  compatibilityDate: '2024-11-01',
  devtools: { enabled: true },
  ssr: false,
  runtimeConfig: {
    public: {
      BASEURL: process.env.BASE_API_URL,
    }
  },
  css: ['~/assets/css/main.css'],
  vite: {
    plugins: [
      tailwindcss(),
    ],
  },
  modules: [
    '@pinia/nuxt'
  ],
  plugins: [
    '~/plugins/api.js',
  ],
  components: [
    {
      path: '~/components',
      pathPrefix: false,
    },
  ],
})
