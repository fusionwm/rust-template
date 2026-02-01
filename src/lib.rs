use crate::plugin::general::logging::info;

wit_bindgen::generate!("general");

pub struct Template;
impl Guest for Template {
    fn init() {
        info("Hello, World!");
    }
}

export!(Template);
