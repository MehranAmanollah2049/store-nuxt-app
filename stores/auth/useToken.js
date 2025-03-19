import { defineStore } from 'pinia'

export const useToken = defineStore('token', () => {

    const token = useCookie('token', {
        sameSite: 'Lax',
        maxAge: 5184000, // 2 months
    });
    const setToken = (val) => {
        token.value = val;
    }

    const removeToken = () => {
        token.value = null
    }

    const getToken = () => token.value

    return { token, setToken, removeToken , getToken }

})