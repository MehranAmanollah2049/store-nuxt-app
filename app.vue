<script setup>
import { Toaster } from "vue-toast-next";
import { useUser } from '~/stores/auth/useUser'


const userStore = useUser();
userStore.load_user()

</script>

<template>
  <div class="w-full min-h-screen flex flex-col overflow-clip relative font-regular">
    <NuxtLoadingIndicator color="var(--theme)"  />
    <Toaster />
    <NuxtLayout>
      <NuxtPage />
    </NuxtLayout>
  </div>
</template>
