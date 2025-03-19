
<template>
    <div class="w-full min-h-screen center">
        <div class="w-[300px] center flex-col gap-1 max-[500px]:w-[70%]">
            <Logo :is_large="true" />  
            <p class="w-full text-title text-[18px] font-bold mb-2 text-center">ورود | ثبت نام</p>       
            <slot />
        </div>
    </div>
</template>