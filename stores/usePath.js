import { defineStore } from 'pinia'

export const usePath = defineStore('path', () => {

    const prev = ref('/');

    return { prev }

})