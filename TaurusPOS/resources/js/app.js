import { createApp, h } from 'vue'
import { createInertiaApp } from '@inertiajs/vue3'
import { InertiaProgress } from '@inertiajs/progress'

// Registrar TODAS las páginas con `import.meta.glob`
const pages = import.meta.glob('./Pages/**/*.vue')

const resolvePageComponent = (name) => {
    const path = `./Pages/${name}.vue`
    if (!pages[path]) {
        throw new Error(`Page not found: ${path}`)
    }
    return pages[path]().then((module) => module.default)
}

createInertiaApp({
    title: (title) => `${title} - TaurusPOS`,
    resolve: (name) => resolvePageComponent(name),
    setup({ el, App, props, plugin }) {
        createApp({ render: () => h(App, props) })
            .use(plugin)
            .mount(el)
    },
})

InertiaProgress.init({ color: '#4B5563' })
