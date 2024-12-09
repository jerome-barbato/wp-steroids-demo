// get modules from templates
let modules = import.meta.glob("../../templates/**/*.js", { eager: true });

export default function loadComponents(app) {

    for (const fileName in modules) {

        const moduleConfig = modules[fileName];
        const moduleName = moduleConfig.default.name || fileName.split('/').pop().replace(/\.\w+$/, '');

        app.component(moduleName, moduleConfig.default || moduleConfig);
    }
}