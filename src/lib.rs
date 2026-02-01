use crate::plugin::general::logging::info;

wit_bindgen::generate!({
    path: "plugin-base",
    world: "general",
});

pub struct Template;
impl Guest for Template {
    fn init() {
        info("Hello, World!");
    }
}

export!(Template);
